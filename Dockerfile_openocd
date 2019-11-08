FROM johnnycubides/linux-litex-base:base

WORKDIR /opt/

RUN git clone https://github.com/ntfreak/openocd.git && \
      cd openocd && \
      ./bootstrap && \
      ./configure --enable-ftdi && \
      make && \
      make install
