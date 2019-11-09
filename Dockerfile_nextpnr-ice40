FROM johnnycubides/linux-litex-base:base

WORKDIR /opt/

RUN wget https://github.com/seccomp/libseccomp/releases/download/v2.4.1/libseccomp-2.4.1.tar.gz && \
      tar xvf libseccomp-2.4.1.tar.gz && \
      rm libseccomp-2.4.1.tar.gz && \
      cd libseccomp-2.4.1 && \
      ./configure && \
      make [V=0] && \
      make install

COPY --from=johnnycubides/linux-icestorm-yosis:icestorm-yosis /opt/icestorm /opt/icestorm

RUN cd icestorm && \
     make install 

COPY --from=johnnycubides/linux-icestorm-yosis:icestorm-yosis /opt/yosys /opt/yosys

RUN cd yosys && \
     make install 

# pendiente, remover los archivos fuente de YOSYS y de ICESTORM ???

RUN git clone https://github.com/YosysHQ/nextpnr nextpnr && \
       cd nextpnr && \
       cmake -DARCH=ice40 -DBUILD_GUI=OFF -DCMAKE_INSTALL_PREFIX=/usr/local .

RUN cd nextpnr && \
      make -j$(nproc)

RUN cd nextpnr && \
      make install
