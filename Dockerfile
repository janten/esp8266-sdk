FROM bitnami/minideb:jessie

RUN install_packages autoconf automake bash bison bzip2 ca-certificates flex g++ gawk gcc git git gperf help2man libexpat-dev libtool libtool-bin make ncurses-dev patch python python-dev python-serial sed texinfo unrar-free unzip wget
RUN mkdir -p /esp && chmod 777 /esp
RUN useradd -ms /bin/bash builder
USER builder
WORKDIR /esp
RUN git clone --depth 1 --recursive https://github.com/pfalcon/esp-open-sdk.git /esp/open-sdk
WORKDIR /esp/open-sdk
RUN make toolchain esptool libhal STANDALONE=n
ENV PATH $PATH:/esp/open-sdk/xtensa-lx106-elf/bin
RUN git clone --depth 1 --recursive https://github.com/Superhouse/esp-open-rtos.git /esp/open-rtos
WORKDIR /esp/open-rtos
ENV SDK_PATH /esp/open-rtos
ENV FLASH_SIZE 8
ENV HOMEKIT_SPI_FLASH_BASE_ADDR 0x7a000
ENV FLASH_MODE dout
USER root
