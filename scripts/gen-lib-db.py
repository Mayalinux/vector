#!/usr/bin/env python3

"""
  gen-lib-db.py: Generates shared object database

  Usage: gen-lib-db.py
"""
import sys
import os
import os.path
import sqlite3
import tarfile

DB_FILE="shared-objects.sqlite"

def help():
  print("Usage: {}".format(sys.argv[0]), file=sys.stderr)

def scan_stage(stage):
  STAGE_DIR="pkgs/stage{}".format(stage)
  
  if not os.path.exists(STAGE_DIR):
    print("Stage directory %s does not exist" % STAGE_DIR, file=sys.stderr)
    sys.exit(1)
  for dirpath, dirnames, filenames in os.walk(STAGE_DIR):
    for f in filenames:
      if f.endswith('.tar.xz'):
        fpath = os.path.join(dirpath, f)
        with tarfile.open(fpath, "r:xz") as tar:
        
          for tarf in tar.getmembers():
            if tarf.isfile() and ('lib/' in tarf.name or 'lib64/' in tarf.name) and '.so' in tarf.name:
              try:
                package=f[:-len('.tar.xz')]
                library=os.path.basename(tarf.name)
                db.execute("INSERT INTO so(package, library, stage) VALUES('{package}','{library}', '{stage}')".format(package=package, library=library, stage=stage))
              except sqlite3.IntegrityError:
                print('WARNING: Integrity error with package="%s", library="%s", stage="%s"' % (package, library, stage), file=sys.stderr)

db = sqlite3.connect(DB_FILE)

db.execute("DROP TABLE IF EXISTS so")
db.execute("CREATE TABLE so(package VARCHAR(256) NOT NULL, library VARCHAR(256) NOT NULL, stage VARCHAR(4), PRIMARY KEY(package, library)) WITHOUT ROWID")

for stage in '123P':
  print('Scanning stage %s...' % stage)
  scan_stage(stage)

db.commit()
db.close()
