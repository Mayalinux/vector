MAYALINUX VECTOR PROJECT
=========

# Introduction
The Vector tool is a builder tool for automating the process of generating a
bootable mayalinux installation image.

# Stages
The project is divided into a number of stages:

1. The system can boot-up, displaying a shell and basic operation can be
   performed (copy, move, delete, mount, etc...).

2. The system has full local operational capabilities. It supports C/C++
   compilation, GNU make, autoconf and other basic build tools. It also supports
   text editing and encryption features.

3. The system supports ethernet and wireless (WEP/WPA) connectivity, both static
   and dynamic (DHCP), text-based web browsing and other basic network-related
   features.

Each stage implements the previous and the vector system can be generated in
whichever stage the user wants.

There is also a special P stage which contains configuration files which are
available to any stage.

# Building
The *scripts* directory contains all the automation scripts used to build the
system. Each script contains a header which explains how to run it and what it
does.

## Needed tools
Here is a list of some needed tools:
* bc
* bison
* binutils supporting sysroots (*see settings.conf.sh-example*)
* perl
* sed
* awk
* gcc
* findutils
* bash
* pkg-config

There might be other I forgot to mention.

## Configuring common options
To configure common build options, such as CFLAGS and LDFLAGS, create in the
root directory a file named *settings.conf.sh* and put there the settings you
need. The settings file is a bash file so you can also run commands within it
and is sourced after the buildfile, only if building.
Refer to the *settings.conf.sh-example* file to see a very basic example of
settings file (which is the one I use).

## Building a single package
The *scripts/build* tool builds a single package and its dependencies.
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
This is just a project I'm mainly working on for myself. It's nerd stuff not
meant to be user-friendly, not meant to be a distro or an alternative to
anything. Nevertheless, if you get this to work and have something to say about
it, I appreciate any feedback.
