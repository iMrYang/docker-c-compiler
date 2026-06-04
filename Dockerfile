FROM debian:11

RUN \
    sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list \
    && apt update \
    && apt install -y \
        gcc-multilib g++-multilib \
	    cmake autoconf automake make patch \
	    valgrind tcpdump strace gdb \
	    diffutils perl \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

CMD [ "/bin/bash" ]