###
### This library contains the common directories
###

# Packages directory
# This directory contains ready-to-deploy packages (each in its stage directory)
PKG_DIR=$(realpath $(dirname "$0"))/../pkgs

# Environment directory
# This directory contains a virtual environment made up by the packages in
# $PKG_DIR
ENV_DIR=$(realpath $(dirname "$0"))/../env

# Stage directory
# This directory contains symlinks to the package files which need to be
# compiled in order to complete the current stage. Each symlink should be
# removed once its relative package is put in the $PKG_DIR directory
STG_DIR=$(realpath $(dirname "$0"))/../stage

# Build directory
# This directory contains the files and directories that will be included
# in the current package.
BLD_DIR=/tmp/pkg

# Builds directory
# This directory contains all the build files
BUILDS_DIR=$(realpath $(dirname "$0"))/../builds

# Cache directory
# This directory contains the downloaded files of every package
CACHE_DIR=$(realpath $(dirname "$0"))/../cache

# Build directory
# This directory contains the source files at compile time
BUILD_DIR=$(realpath $(dirname "$0"))/../build

# Patch directory
# This directory contains all the custom patch files
PATCH_DIR=$(realpath $(dirname "$0"))/../patches

# Other directory
# This directory contains any other file that isn't suitable to be contained
# in one of the other directories
OTHER_DIR=$(realpath $(dirname "$0"))/../other
