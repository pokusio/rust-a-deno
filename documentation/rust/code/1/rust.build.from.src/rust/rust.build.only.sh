#!/bin/sh

if [ "x${RUST_PLANET}" == 'x' ]; then
  # subtle ways later on:
  echo 'The RUST_PLANET env. var. is not set, but must be' >&2
  exit 1
else
  if [ -f ./config.toml ]; then
    rm -f ./config.toml
  fi
  if [ "${RUST_PLANET}" == 'true' ]; then
    echo "The RUST_PLANET env. var. is set to 'true', so we will use the "
    echo "[config.alltools.toml] configuration file. In consequence, several "
    echo "utilities will be installed, e.g. cargo package manager"
    cp ./config.alltools.toml ./config.toml
  else
    echo "The RUST_PLANET env. var. is set to 'false', so we will use the "
    echo "[config.minimal.toml] configuration file. In consequence, several "
    echo "utilities won't be installed, e.g. cargo package manager will not be installed"
    cp ./config.minimal.toml ./config.toml
  fi
fi
./x.py build
