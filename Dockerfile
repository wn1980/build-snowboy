# build last version
# docker build -t wn1980/build-snowboy .

# compile into local /tmp/snowboy
# docker run -it --rm -v "$(pwd)/src:/src" wn1980/build-snowboy bash

FROM ubuntu

LABEL maintainer="Waipot Ngamsaad <waipotn@hotmail.com>"

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND noninteractive

RUN  apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

RUN sed -i -e 's/http:\/\/archive/mirror:\/\/mirrors/' -e 's/http:\/\/security/mirror:\/\/mirrors/' -e 's/\/ubuntu\//\/mirrors.txt/' /etc/apt/sources.list

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
	ca-certificates \
	git \
	nano \
	wget \
	make \
	g++ \
	gfortran \
	libtool \
	python3-dev \
	python3-pip \
	portaudio19-dev \
	alsa-utils \
	libatlas3-base \
	libatlas-base-dev \
	libblas-dev \
	libpcre3-dev \
	libdpkg-perl

RUN pip3 install pyaudio

#ENV VERSION=3.0.12
ENV VERSION=4.0.2
RUN wget https://downloads.sourceforge.net/swig/swig-$VERSION.tar.gz && tar xzf swig-$VERSION.tar.gz
RUN cd swig-$VERSION && \
    ./configure --prefix=/usr \
    --without-clisp  \
    --without-maximum-compile-warnings && \
    make

RUN cd swig-$VERSION && \
    make install && \
    install -v -m755 -d /usr/share/doc/swig-$VERSION && \
    cp -v -R Doc/* /usr/share/doc/swig-$VERSION

RUN mkdir -p workspace
WORKDIR /workspace
