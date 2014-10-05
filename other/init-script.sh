#!/bin/bash

export PATH="/bin:/sbin:/usr/bin:/usr/sbin"

exec /bin/bash

mount -t devtmpfs none /dev
mkdir -p /dev/{shm,pts}

mount -t proc none /proc
mount -t tmpfs none /run
mount -t tmpfs none /dev/shm
mount -t devpts none /dev/pts

echo TEST!

exec /bin/bash
