FROM ubuntu:19.10

RUN apt-get update -y && apt-get install -y git gcc make g++ device-tree-compiler

# spike build tools and dependencies
RUN apt-get install -y gcc-riscv64-unknown-elf gcc-riscv64-linux-gnu g++-riscv64-linux-gnu

# installing newlib & pk. these are not required for bare metal (see examples in README.md) 

RUN git clone https://github.com/riscv/riscv-newlib.git

RUN cd /riscv-newlib && \
    mkdir build && \
    cd build && \
    ../configure  --target=riscv64-unknown-elf && \
    make -j$(nproc) && \
    make install

RUN git clone https://github.com/riscv/riscv-pk.git

RUN cd /riscv-pk && \
    mkdir build && \
    cd build && \
    ../configure --prefix=/usr/local --host=riscv64-unknown-elf LDFLAGS="-B /usr/local/riscv64-unknown-elf/lib/rv64imafdc/lp64d/" CFLAGS="-I/usr/local/riscv64-unknown-elf/include/ -nostdlib" && \
    make CFLAGS="-I/usr/local/riscv64-unknown-elf/include/ -DBBL_PAYLOAD=\\\"bbl_payload\\\" -DBBL_LOGO_FILE=\\\"bbl_logo_file\\\" -mcmodel=medany -nostdlib" && \
    make install

# installing spike iself

RUN git clone https://github.com/riscv/riscv-isa-sim.git

RUN cd /riscv-isa-sim && \
    mkdir build && \
    cd build && \ 
    ../configure --prefix=/usr/local && \
    make && \
    make install

# pass all commands transparently into container
ENTRYPOINT ["bash", "-lc"]

