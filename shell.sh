#!/usr/bin/env bash

set -e

cache_dir="lib"
if [ ! -e ./$cache_dir/ ]; then
    mkdir $cache_dir
fi

if [ $(uname -s) = "Darwin" ]; then
    nix-shell src/darwin.nix
else
    nix-shell src/linux.nix
fi
