MAYALINUX VECTOR PROJECT
=========

# Introduction
The Vector tool is a builder tool for automating the process of generating a
bootable mayalinux installation image.

# Stages
The project is divided into a number of stages:

1. The system can boot-up, displaying a shell and basic operation can be
   performed (copy, move, delete, mount, etc...).

2. The system can edit text files and has connectivity (ethernet, WEP, WPA)
   via static or dynamic IP (DHCP). A text-based browser is also provided along
   with at least a ping tool and curl.

3. The system has basic compilation support for C/C++ along with some best known
   build tools.

Each stage implements the previous and the vector system can be generated in
whichever stage the user wants.

There is also a special P stage which contains configuration files which are
available to any stage.

# Building
The *scripts* directory contains all the automation scripts used to build the
system. Each script contains a header which explains how to run it and what it
does.

## Building a single package
The *scripts/builder* tool builds a single package and its dependencies.
Each package contains a **build file** in the *builds/* directory which is used
to configure the build process.

## Building a stage
You may run *scripts/build-stage* to build a particular stage.

## Cleaning things up
You may run *scripts/groundup* to clean the build environment.

## Building the initramfs
To boot the vector system you need to provide a valid initramfs. This can be
done automatically by calling the *script/gen-initramfs* script, which builds
the stage 1, generates the initramfs directory, provides the kernel a cpio index
file and triggers a rebuild, refreshing the kernel image into the kernel
package.

## Running the vector system
To run the vector system, you need to mount an empty drive to some directory,
run the *scripts/install* script and install a bootloader. Don't forget to
generate the initramfs before attempting to boot the kernel or you might end up
with a kernel panic.

# About the project
This is just a projcet I'm mainly working on for myself. It's nerd stuff not
meant to be user-friendly, not meant to be a distro or an alternative to
anything. Nevertheless, if you get this to work and have something to say about
it, I appreciate any feedback.
