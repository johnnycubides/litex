FROM johnnycubides/linux-litex-base:base

WORKDIR /opt/

RUN wget http://www.das-labor.org/files/madex/lm32_linux_i386.tar.bz2 && \
      tar -xvjf lm32_linux_i386.tar.bz2 && \
      rm lm32_linux_i386.tar.bz2 && \
      echo 'export PATH=/opt/lm32/bin/:$PATH' >> /root/.bashrc
