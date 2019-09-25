### IMAGEN BASE ###
FROM debian:buster

### TOOLS ###
RUN apt-get update
RUN apt-get install -y libusb-1.0-0 usbutils libftdi1

### INTALACIÓN DE LITEX ###
RUN apt-get install -y python3 python3-setuptools git wget nano
RUN wget --no-verbose --continue https://raw.githubusercontent.com/enjoy-digital/litex/master/litex_setup.py && \
    python3 litex_setup.py init install && \
    python3 litex_setup.py update

### DEPENDENCIAS PARA YOSIS ICESTORM, NEXTPNR Y ARACHNE-PNR ###
RUN apt-get install -y build-essential clang bison flex libreadline-dev \
      gawk tcl-dev libffi-dev mercurial graphviz   \
      xdot pkg-config python libftdi-dev \
      qt5-default python3-dev libboost-all-dev cmake

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

### ARACHNE-PNR ###
### DEJARÁ DE SER MANTENIDO, SU REMPLAZO ES nextpnr ###
RUN git clone https://github.com/cseed/arachne-pnr.git arachne-pnr && \
      cd arachne-pnr && \
      make -j$(nproc) && \
      make install

### NEXTPNR ###
### ÉSTE ES EL SUSTITUTO DE arachne-pnr ###
# RUN apt-get install -y cmake qt5-default
# RUN git clone https://github.com/YosysHQ/nextpnr nextpnr && \
#       cd nextpnr && \
#       cmake -DARCH=ice40 -DCMAKE_INSTALL_PREFIX=/usr/local . && \
#       make -j$(nproc) && \
#       make install

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

CMD '/bin/bash'
