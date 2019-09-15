#!/usr/bin/env bash

cd /workspace

cd snowboy/swig/Python3 && make
python3 -c "import _snowboydetect; print('OK')"

cd /workspace

export ARCH=$(uname -m) && export VERSION=$(grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"')
export output=build/Python3/${VERSION}-${ARCH}

rm -rf $output
mkdir -p $output
cp snowboy/swig/Python3/* $output
