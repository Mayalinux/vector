#!/usr/bin/perl
#
# Shared objects database generator
# 
# Usage: gen-lib-db.pl [package]
#
# package: package file to add to the database.
#
# If no argument is provided, generates a new database from the compiled
# packages.
#
use strict;
use warnings;
use feature qw(say);
use Cwd qw(abs_path getcwd);
use File::Spec;
use File::Find;
use DBI;
use Archive::Tar;
use Archive::Tar::Constant;
use constant DB_PATH => 'shared-objects.sqlite';
use constant STAGES_DIR => 'pkgs'; # Directory name in base_dir

my @shared;
my $base_dir;
my $package;
do {
  my ($vol, $dir, $fname) = File::Spec->splitpath($0);
  $base_dir = abs_path(File::Spec->catdir(getcwd, $dir, '/../'));
};
my $stages_dir = File::Spec->catdir($base_dir, STAGES_DIR);
my $db_path = File::Spec->catfile($base_dir, DB_PATH);

$package = $ARGV[0] if defined $ARGV[0];

# Checks whether the provided ($_) file is a wanted file
# 
# Usage: file_wanted
sub file_wanted {
  return (-f && /\.tar\.xz$/);
}

# Function passed to find(). For each filename ($_) accepted by file_wanted(), extracts its shared object filenames
# and puts them in @shared, in the form [so_name, pkg_name].
#
# Usage: file_func
sub file_func {
  unless(file_wanted $_) {
    say STDERR "Ignoring file $_..." if -f $_;
    return;
  }

  open my $tar_file, '-|', "xz --decompress --stdout $_" or die("Unable to open $_");
  my $tar = Archive::Tar->new($tar_file) or die('Unable to open tar file');
  my @files = $tar->get_files;
  
  for (@files) {
    next unless ($_->name =~ /\.so[0-9.]*/ && $_->type == FILE && $_->mode & 0500 && $_->name !~ /\/perl[0-9]+\//);
    push @shared, [$_->name, $File::Find::name];
  }

  undef @files;
  undef $tar;
  close $tar_file;
}

# Put the needed SOs in @shared
if (not defined $package) {
  for (1..3, 'P') {
    say "Scanning stage $_...";
    File::Find::find({ 'wanted' => \&file_func, 'no_chdir' => 1}, File::Spec->catdir($stages_dir, "stage$_"));
  }
} else {
  $_ = $package;
  file_func;
}

# Remove paths and extensions
@shared = map {
  my @cur = @{$_};
  
  my ($vol, $dir, $fname) = File::Spec->splitpath($cur[0]);
  $cur[0] = $fname;
  ($vol, $dir, $fname) = File::Spec->splitpath($cur[1]);
  $fname =~ s/\.tar\.xz$//;
  $cur[1] = $fname;

  \@cur;
} @shared;

my $db = DBI->connect("dbi:SQLite:dbname=$db_path", '', '', { 'RaiseError' => 1 }) or die $DBI::errstr;

$db->begin_work;
if (not defined $package) {
  $db->do('DROP TABLE IF EXISTS so');
  $db->do('CREATE TABLE so(library VARCHAR(256) NOT NULL PRIMARY KEY ON CONFLICT IGNORE, package VARCHAR(256) NOT NULL) WITHOUT ROWID')
    or die("Unable to create database: $db->errstr");
}

my $stmt = $db->prepare('INSERT INTO so VALUES(?, ?)');

for (@shared) {
  my @rec = @{$_};
  my $soname = $rec[0];
  my $pkname = $rec[1];

  $stmt->execute($soname, $pkname) or warn "Unable to insert $soname: $db->errstr";
}

$db->commit;
$db->disconnect;
