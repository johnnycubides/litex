### IMAGEN BASE ###
FROM debian:buster

### TOOLS ###
RUN apt-get update
RUN apt-get install -y libusb-1.0-0 usbutils libftdi1 busybox

### DEPENDENCIAS PARA YOSIS ICESTORM, NEXTPNR Y ARACHNE-PNR ###
RUN apt-get install -y build-essential clang bison flex libreadline-dev \
      gawk tcl-dev libffi-dev mercurial graphviz   \
      xdot pkg-config python libftdi-dev \
      qt5-default python3-dev libboost-all-dev cmake wget

RUN wget https://github.com/seccomp/libseccomp/releases/download/v2.4.1/libseccomp-2.4.1.tar.gz && \
      tar xvf libseccomp-2.4.1.tar.gz && \
      rm libseccomp-2.4.1.tar.gz && \
      cd libseccomp-2.4.1 && \
      ./configure && \
      make [V=0] && \
      make install

RUN apt-get install -y python3 python3-setuptools git nano

### INSTALACIÓN DE ICESTORM ###
RUN git clone https://github.com/cliffordwolf/icestorm.git icestorm && \
      cd icestorm && \
      make -j$(nproc) && \
      make install

### NEXTPNR ###
### ÉSTE ES EL SUSTITUTO DE arachne-pnr ###
RUN apt-get install -y cmake qt5-default libeigen3-dev
RUN git clone https://github.com/YosysHQ/nextpnr nextpnr && \
      cd nextpnr && \
      cmake -DARCH=ice40 -DCMAKE_INSTALL_PREFIX=/usr/local . && \
      make -j$(nproc) && \
      make install

### INTALACIÓN DE LITEX ###
RUN apt-get install -y python3 python3-setuptools git nano
RUN wget --no-verbose --continue https://raw.githubusercontent.com/enjoy-digital/litex/master/litex_setup.py && \
    python3 litex_setup.py init install && \
    python3 litex_setup.py update

### INSTALACIÓN DE YOSYS ###
RUN git clone https://github.com/cliffordwolf/yosys.git yosys && \
      cd yosys && \
      make -j$(nproc) && \
      make install

### ARACHNE-PNR ###
### DEJARÁ DE SER MANTENIDO, SU REMPLAZO ES nextpnr ###
RUN git clone https://github.com/cseed/arachne-pnr.git arachne-pnr && \
      cd arachne-pnr && \
      make -j$(nproc) && \
      make install

### VERILATOR PARA SIMULAR ###
RUN apt-get install -y verilator libevent-dev libjson-c-dev

### OPENOCD PARA PRUEBAS DE HARDWARE ###
# Observación, debe ser verificado
RUN apt-get install -y libtool automake pkg-config libusb-1.0-0-dev
RUN cd /opt/ && \
      git clone https://github.com/ntfreak/openocd.git && \
      cd openocd && \
      ./bootstrap && \
      ./configure --enable-ftdi && \
      make && \
      make install

###  RISC-V TOOLCHAIN ###
RUN apt-get install -y build-essential device-tree-compiler
RUN cd /opt/ && \
      wget https://static.dev.sifive.com/dev-tools/riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14.tar.gz  && \
      tar -xvf riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14.tar.gz && \
      rm riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14.tar.gz && \
      touch /root/.bashrc && \
      echo 'export PATH=$PATH:/opt/riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14/bin/' >> /root/.bashrc

### LM32 TOOLCHAIN ###
RUN cd /opt/ && \
      wget http://www.das-labor.org/files/madex/lm32_linux_i386.tar.bz2 && \
      tar -xvjf lm32_linux_i386.tar.bz2 && \
      rm lm32_linux_i386.tar.bz2 && \
      echo 'export PATH=/opt/lm32/bin/:$PATH' >> /root/.bashrc

RUN apt-get install -y vim

RUN git clone --recursive https://github.com/SymbiFlow/prjtrellis && \
      cd prjtrellis/libtrellis && \
      cmake -DCMAKE_INSTALL_PREFIX=/usr . && \
      make && \
      make install && \
      cmake -DARCH=ecp5 -DTRELLIS_ROOT=prjtrellis . && \
      make -j$(nproc) && \
      make install

RUN cd nextpnr && \
      cmake -DARCH=ecp5 -DTRELLIS_ROOT=/prjtrellis . && \
      make -j$(nproc) && \
      make install

# TOOL CHAIN RISC-V GC
# Dependencias
RUN apt-get install -y autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev
# colando recursivamente
RUN git clone https://github.com/riscv/riscv-gnu-toolchain && \
      cd riscv-gnu-toolchain && \
      git submodule update --init --recursive
# construyendo...
RUN cd riscv-gnu-toolchain && \
      ./configure --prefix=/opt/riscv --with-arch=rv32gc --with-abi=ilp32d && \
      make linux
      # make linux -j$(nproc)

# RUN apt-get install -y autoconf autotools-dev curl libmpc-dev \
#         libmpfr-dev libgmp-dev texinfo \
#     gperf patchutils bc zlib1g-dev libexpat1-dev

# RUN mkdir /opt/riscv32i

# RUN git clone https://github.com/riscv/riscv-gnu-toolchain riscv-gnu-toolchain-rv32i && \
#       cd riscv-gnu-toolchain-rv32i && \
#       git checkout 411d134 && \
#       git submodule update --init --recursive && \
#       mkdir build; cd build && \
#       ../configure --with-arch=rv32i --prefix=/opt/riscv32i && \
#       make -j$(nproc)

CMD '/bin/bash'
