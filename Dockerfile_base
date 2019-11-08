### IMAGEN BASE ###
FROM debian:buster

WORKDIR /opt/

### TOOLS ###
RUN apt-get update
RUN apt-get install -y libusb-1.0-0 usbutils libftdi1 busybox vim

### DEPENDENCIAS PARA YOSIS ICESTORM, NEXTPNR Y ARACHNE-PNR ###
RUN apt-get install -y build-essential clang bison flex libreadline-dev \
      gawk tcl-dev libffi-dev git mercurial graphviz   \
      xdot pkg-config python libftdi-dev \
      python3-dev libboost-all-dev cmake wget \
      python3 python3-setuptools nano \
      cmake libeigen3-dev

RUN apt-get install -y libtool automake libusb-1.0-0-dev device-tree-compiler
RUN apt-get install -y autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev texinfo gperf patchutils bc zlib1g-dev libexpat-dev
