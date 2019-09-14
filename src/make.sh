#!/usr/bin/env bash

cd /src/snowboy/swig/Python3 && make
python3 -c "import _snowboydetect; print('OK')"

export ARCH=$(uname -m) && export VERSION=$(grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"')
export output=/src/build/Python3/${VERSION}-${ARCH}

rm -rf $output
mkdir -p $output
cp /src/snowboy/swig/Python3/* $output
