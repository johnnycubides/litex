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

### INSTALACIÓN DE ICESTORM ###
RUN git clone https://github.com/cliffordwolf/icestorm.git icestorm && \
      cd icestorm && \
      make -j$(nproc) && \
      make install

### INSTALACIÓN DE YOSYS ###
RUN git clone https://github.com/cliffordwolf/yosys.git yosys && \
      cd yosys && \
      make -j$(nproc) && \
      make install

RUN wget https://github.com/seccomp/libseccomp/releases/download/v2.4.1/libseccomp-2.4.1.tar.gz && \
      tar xvf libseccomp-2.4.1.tar.gz && \
      rm libseccomp-2.4.1.tar.gz && \
      cd libseccomp-2.4.1 && \
      ./configure && \
      make [V=0] && \
      make install

### NEXTPNR ###
## ÉSTE ES EL SUSTITUTO DE arachne-pnr ###
RUN git clone https://github.com/YosysHQ/nextpnr nextpnr && \
       cd nextpnr && \
       cmake -DARCH=ice40 -DBUILD_GUI=OFF -DCMAKE_INSTALL_PREFIX=/usr/local . && \
       make -j$(nproc) && \
       make install

RUN git clone --recursive https://github.com/SymbiFlow/prjtrellis && \
      cd prjtrellis/libtrellis && \
      cmake -DCMAKE_INSTALL_PREFIX=/usr . && \
      make && \
      make install

RUN cd nextpnr && \
      # cmake -DARCH=ecp5 -DBUILD_GUI=OFF -DTRELLIS_ROOT=/opt/prjtrellis . && \
      cmake -DARCH=ecp5 -DBUILD_GUI=OFF -DTRELLIS_ROOT=/opt/prjtrellis .
      # make -j$(nproc) && \
      # make install

# ### INTALACIÓN DE LITEX ###
# RUN wget --no-verbose --continue https://raw.githubusercontent.com/enjoy-digital/litex/master/litex_setup.py && \
#     python3 litex_setup.py init install && \
#     python3 litex_setup.py update

# ### ARACHNE-PNR ###
# ### DEJARÁ DE SER MANTENIDO, SU REMPLAZO ES nextpnr ###
# RUN git clone https://github.com/cseed/arachne-pnr.git arachne-pnr && \
#       cd arachne-pnr && \
#       make -j$(nproc) && \
#       make install

# ### VERILATOR Y GTKWAVE PARA SIMULAR ###
# RUN apt-get install -y verilator libevent-dev libjson-c-dev gtkwave

# ### OPENOCD PARA PRUEBAS DE HARDWARE ###
# # Observación, debe ser verificado
# RUN apt-get install -y libtool automake pkg-config libusb-1.0-0-dev
# RUN cd /opt/ && \
#       git clone https://github.com/ntfreak/openocd.git && \
#       cd openocd && \
#       ./bootstrap && \
#       ./configure --enable-ftdi && \
#       make && \
#       make install

# ###  RISC-V TOOLCHAIN ###
# RUN apt-get install -y build-essential device-tree-compiler
# RUN cd /opt/ && \
#       wget https://static.dev.sifive.com/dev-tools/riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14.tar.gz  && \
#       tar -xvf riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14.tar.gz && \
#       rm riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14.tar.gz && \
#       touch /root/.bashrc && \
#       echo 'export PATH=$PATH:/opt/riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14/bin/' >> /root/.bashrc

# ### LM32 TOOLCHAIN ###
# RUN cd /opt/ && \
#       wget http://www.das-labor.org/files/madex/lm32_linux_i386.tar.bz2 && \
#       tar -xvjf lm32_linux_i386.tar.bz2 && \
#       rm lm32_linux_i386.tar.bz2 && \
#       echo 'export PATH=/opt/lm32/bin/:$PATH' >> /root/.bashrc

# CMD '/bin/bash'
