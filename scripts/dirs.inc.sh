###
### This library contains the common directories
###

# Base directory
# This is the root directory of the project
BASE_DIR="$(realpath -L -P $(dirname "$0")/..)"

# Stages directory
# This directory contains ready-to-deploy packages (each in its stage directory)
STAGES_DIR=$BASE_DIR/pkgs

# Environment directory
# This directory contains a virtual environment made up by the packages in
# $STAGES_DIR
ENV_DIR=$BASE_DIR/env

# Installation directory
# This directory contains the files and directories that will be included
# in the current package.
INSTALL_DIR=/tmp/pkg

# Builds directory
# This directory contains all the build files
BUILDS_DIR=$BASE_DIR/builds

# Cache directory
# This directory contains the downloaded files of every package
CACHE_DIR=$BASE_DIR/cache

# Build directory
# This directory contains the source files at compile time
BUILD_DIR=$BASE_DIR/build

# Patch directory
# This directory contains all the custom patch files
PATCHES_DIR=$BASE_DIR/patches

# Other directory
# This directory contains any other file that isn't suitable to be contained
# in one of the other directories
OTHER_DIR=$BASE_DIR/other

# Initramfs directory
# This directory contains the files that will be added to the initramfs
INITRAMFS_DIR=$BASE_DIR/initramfs

# Shared object dependencies log file
# This file contains information about the shared objects needed for a package
DEP_LOGFILE=/tmp/pkg_dependencies.log

# Package database
# This sqlite3 database contains information about built packages
DB_PACKAGES=$BASE_DIR/packages.sqlite

# Shared objects database
# This sqlite3 database contains information about the environment's shared objects
DB_SHARED=$BASE_DIR/shared-objects.sqlite
