#!/bin/bash

export PATH="/bin:/sbin:/usr/bin:/usr/sbin"

mount -t devtmpfs none /dev
mkdir -p /dev/{shm,pts}

mount -t proc proc /proc
mount -t tmpfs run /run
mount -t tmpfs devshm /dev/shm
mount -t devpts devpts /dev/pts
mount -t sysfs sys /sys
mount -t tmpfs cgroup_root /sys/fs/cgroup

exec /bin/bash
