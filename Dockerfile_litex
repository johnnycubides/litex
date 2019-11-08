FROM johnnycubides/linux-litex-base:base

WORKDIR /opt/

RUN wget --no-verbose --continue https://raw.githubusercontent.com/enjoy-digital/litex/master/litex_setup.py && \
    python3 litex_setup.py init install && \
    python3 litex_setup.py update
