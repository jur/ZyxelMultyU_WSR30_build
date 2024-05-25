# Dockerfile for building firmware for WSR30 (RTL8198C)
FROM ubuntu:12.04

# Fix server:
RUN sed -ie "s#archive.ubuntu.com#old-releases.ubuntu.com#g" /etc/apt/sources.list

RUN apt-get update
RUN apt-get upgrade -y

# Some useful tools
RUN apt-get install -y git xz-utils
RUN apt-get install -y vim gawk unzip wget subversion file curl make python aptitude
RUN apt-get install -y gcc g++ bzip2
RUN apt-get install -y sudo cpio

# Commands taken from 100ABMY13C0/README.md:
RUN apt-get install -y ia32-libs-multiarch:i386
RUN apt-get install -y ia32-libs

# make /bin/sh symlink to bash instead of dash:
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

RUN apt-get install -y zlib1g-dev bison flex gawk autoconf libtool cmake lua5.1
RUN apt-get install -y ncurses-base ncurses-bin ncurses-term libncurses5 libncurses5-dev

# Packages required for building:
RUN apt-get install -y pkg-config libffi-dev gettext liblzma-dev libglib2.0-dev libdbus-1-dev bc lzma

RUN useradd -ms /bin/bash builduser
RUN adduser builduser sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers
USER builduser
WORKDIR /home/builduser
