###
### This library contains the common directories
###

# Packages directory
# This directory contains ready-to-deploy packages
PKG_DIR=$(dirname "$0")/../pkgs

# Environment directory
# This directory contains a virtual environment made up by the packages in
# $PKG_DIR
ENV_DIR=$(dirname "$0")/../env

# Stage directory
# This directory contains symlinks to the package files which need to be
# compiled in order to complete the current stage. Each symlink should be
# removed once its relative package is put in the $PKG_DIR directory
STG_DIR=$(dirname "$0")/../stage

# Build directory
# This directory contains the files and directories that will be included
# in the current package.
BLD_DIR=/tmp/pkg

# Builds directory
# This directory contains all the build files
BUILDS_DIR=$(dirname "$0")/../builds
