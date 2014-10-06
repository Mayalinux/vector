###
### This library contains the common directories
###

# Stages directory
# This directory contains ready-to-deploy packages (each in its stage directory)
STAGES_DIR=$(realpath $(dirname "$0"))/../pkgs

# Environment directory
# This directory contains a virtual environment made up by the packages in
# $STAGES_DIR
ENV_DIR=$(realpath $(dirname "$0"))/../env

# Installation directory
# This directory contains the files and directories that will be included
# in the current package.
INSTALL_DIR=/tmp/pkg

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
PATCHES_DIR=$(realpath $(dirname "$0"))/../patches

# Other directory
# This directory contains any other file that isn't suitable to be contained
# in one of the other directories
OTHER_DIR=$(realpath $(dirname "$0"))/../other

# Initramfs directory
# This directory contains the files that will be added to the initramfs
INITRAMFS_DIR=$(realpath $(dirname "$0"))/../initramfs
