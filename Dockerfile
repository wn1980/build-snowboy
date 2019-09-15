# build last version
# docker build -t wn1980/build-snowboy .

# compile into local /tmp/snowboy
# docker run -it --rm -v "$(pwd)/src:/src" wn1980/build-snowboy bash

FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y \
	git vim wget \
	make g++ gfortran libtool \
	python3-dev \
	python3-pip \
	portaudio19-dev \
	alsa-utils \
	libatlas3-base libatlas-base-dev libblas-dev \
	libpcre3-dev \
	libdpkg-perl

RUN pip3 install pyaudio

RUN wget https://downloads.sourceforge.net/swig/swig-3.0.12.tar.gz && tar xzf swig-3.0.12.tar.gz
RUN cd swig-3.0.12 && \
    ./configure --prefix=/usr \
    --without-clisp  \
    --without-maximum-compile-warnings && \
    make

RUN cd swig-3.0.12 && \
    make install && \
    install -v -m755 -d /usr/share/doc/swig-3.0.12 && \
    cp -v -R Doc/* /usr/share/doc/swig-3.0.12

RUN mkdir -p workspace
WORKDIR /workspace
