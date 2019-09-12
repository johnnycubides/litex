FROM debian:buster

RUN apt-get update
RUN apt-get install -y python3 python3-setuptools git wget nano
RUN wget --no-verbose --continue https://raw.githubusercontent.com/enjoy-digital/litex/master/litex_setup.py && \
    python3 litex_setup.py init install && \
    python3 litex_setup.py update

RUN apt-get install -y build-essential clang bison flex libreadline-dev \
      gawk tcl-dev libffi-dev mercurial graphviz   \
      xdot pkg-config python libftdi-dev \
      qt5-default python3-dev libboost-all-dev cmake

RUN git clone https://github.com/cliffordwolf/icestorm.git icestorm && \
      cd icestorm && \
      make -j$(nproc) && \
      make install

RUN git clone https://github.com/cliffordwolf/yosys.git yosys && \
      cd yosys && \
      make -j$(nproc) && \
      make install
# DEJARÁ DE SER MANTENIDO SU REMPLAZO ES nextpnr
# RUN git clone https://github.com/cseed/arachne-pnr.git arachne-pnr && \
#       cd arachne-pnr && \
#       make -j$(nproc) && \
#       make install
# SUSTITUTO DE arachne-pnr
# RUN apt-get install -y cmake qt5-default
# RUN git clone https://github.com/YosysHQ/nextpnr nextpnr && \
#       cd nextpnr && \
#       cmake -DARCH=ice40 -DCMAKE_INSTALL_PREFIX=/usr/local . && \
#       make -j$(nproc) && \
#       make install
# RUN wget https://raw.githubusercontent.com/enjoy-digital/litex/master/litex_setup.py

CMD '/bin/bash'
