#!/bin/bash

###
### Removes a package from the installed packages database.
###
####
#### Usage: remove-pkg.sh PKG_NAME
####
####  PKG_NAME: Name of package to remove.
####

source $(dirname "$0")/private/dirs.inc.sh
cd $BASE_DIR

PKG_NAME="$1"

[[ -z "$PKG_NAME" ]] && echo "ERROR: Missing package name." >&2 && exit 1

PKG_NAME="${PKG_NAME//\\/\\\\}"
PKG_NAME="${PKG_NAME//\'/\\\'}"

sqlite3 "$DB_PACKAGES" "DELETE FROM packages WHERE name='$PKG_NAME'"
