FROM centos:8

RUN \
    sed -i 's/mirrorlist=/#mirrorlist=/g' /etc/yum.repos.d/CentOS-*.repo \
    && sed -i 's/#baseurl=http:\/\/mirror.centos.org/baseurl=https:\/\/mirrors.aliyun.com/g' /etc/yum.repos.d/CentOS-*.repo \
    && yum install -y \
        gcc glibc-devel glibc.i686 glibc-devel.i686 \
        gcc-c++ libstdc++-devel libstdc++-devel.i686 \
        autoconf automake make patch \
        valgrind tcpdump strace gdb \
        diffutils perl wget \
    && yum -y clean all \
    && wget https://github.com/Kitware/CMake/releases/download/v3.25.3/cmake-3.25.3-linux-x86_64.sh -O /tmp/cmake-install.sh \
    && chmod +x /tmp/cmake-install.sh \
    && /tmp/cmake-install.sh --skip-license --prefix=/usr/local \
    && rm -f /tmp/cmake-install.sh

CMD [ "/bin/bash" ]

