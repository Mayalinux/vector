#!/bin/bash

###
### Library finder. Finds shared libraries in the shared-objects database.
###
####
#### Usage: find-lib.sh LIBNAME
####
####  LIBNAME: Name of library to search for.
####
#### The script will print all the libraries containing the LIBNAME string.
####

source $(dirname "$0")/private/dirs.inc.sh
cd $BASE_DIR

LIBNAME="$1"

[[ -z "$LIBNAME" ]] && echo "ERROR: Missing search pattern." >&2 && exit 1

LIBNAME="${LIBNAME//\\/\\\\}"
LIBNAME="${LIBNAME//\'/\\\'}"

sqlite3 "$DB_SHARED" "SELECT * FROM so WHERE library LIKE '%$LIBNAME%'"
