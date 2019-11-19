# YOSIS AND NEXTPNR AND LITEX ICE40
FROM johnnycubides/litex-nextpnr-ice40:litex-nextpnr-ice40

WORKDIR /opt/

# RISCV-GC
COPY --from=johnnycubides/linux-rv32gv:rv32gc /opt/riscv /opt/riscv

RUN echo 'export PATH=/opt/riscv/bin/:$PATH' >> /root/.bashrc


