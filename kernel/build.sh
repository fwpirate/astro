#!/bin/bash
KERNEL_DIR="linux"
CONFIG_DIR="config"
PATCH_DIR="patches"

cd "$KERNEL_DIR" || exit

for patch in ../$PATCH_DIR/*.patch; do
    [ -f "$patch" ] && patch -p1 < "$patch"
done

cp "../$CONFIG_DIR/.config" .config

if [[ "$(uname)" == "Darwin" ]]; then
    JOBS=$(sysctl -n hw.ncpu)
else
    JOBS=$(nproc)
fi

# Run make commands
make oldconfig
make -j"$JOBS"
