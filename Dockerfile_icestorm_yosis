FROM johnnycubides/linux-litex-base:base

WORKDIR /opt/

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
