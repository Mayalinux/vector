#!/usr/bin/env python3

import sys
import os
import os.path
import sqlite3
import tarfile

DB_FILE="shared-objects.sqlite"

def help():
  print("Usage: {} STAGE#".format(sys.argv[0]), file=sys.stderr)

if len(sys.argv) != 2:
  help()
  sys.exit(1)

STAGE_DIR="pkgs/stage{}".format(sys.argv[1])

if not os.path.exists(STAGE_DIR):
  help()
  sys.exit(1)

db = sqlite3.connect(DB_FILE)

db.execute("DROP TABLE IF EXISTS so")
db.execute("CREATE TABLE so(package VARCHAR(256) NOT NULL, library VARCHAR(256) NOT NULL, PRIMARY KEY(package, library)) WITHOUT ROWID")

for dirpath, dirnames, filenames in os.walk(STAGE_DIR):
  for f in filenames:
    if f.endswith('.tar.xz'):
      fpath = os.path.join(dirpath, f)
      with tarfile.open(fpath, "r:xz") as tar:
      
        for tarf in tar.getmembers():
          if tarf.isfile() and ('lib/' in tarf.name or 'lib64/' in tarf.name) and '.so' in tarf.name:
            db.execute("INSERT INTO so(package, library) VALUES('{package}','{library}')".format(package=f[:-len('.tar.xz')], library=os.path.basename(tarf.name)))

db.commit()
db.close()
