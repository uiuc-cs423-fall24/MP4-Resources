#!/usr/bin/env bash

set -e

if [[ $# -ne 1 ]]; then
    echo "$0 <mp4_dir>" >&2
    exit 2
fi

script_dir=$(dirname "$0")
mp4_dir=$1

rust_dist_dir=${mp4_dir}/rust/dist

# Put kernel source into correct place
tar xf ${script_dir}/linux/linux-rex.tar.xz -C ${mp4_dir}

# Install Rust artifact
mkdir -p ${mp4_dir}/rust/dist
for f in ${script_dir}/rust/*.xz; do
	tar xf $f 
	$(basename ${f%.*.*})/install.sh --destdir=${mp4_dir}/rust/dist --prefix='' --disable-ldconfig
	rm -rf $(basename ${f%.*.*})
done
