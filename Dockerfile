FROM centos:5 as builder

COPY perl5-perl-5.10.1.tar.gz /tmp

COPY cmake-3.2.3-Linux-x86_64.sh /tmp

RUN \
    sed -i 's/enabled=1/enabled=0/' /etc/yum/pluginconf.d/fastestmirror.conf \
        && sed -i 's/mirrorlist/#mirrorlist/' /etc/yum.repos.d/*.repo \
        && sed -i 's|#baseurl=http://mirror.centos.org/centos/$releasever|baseurl=http://mirrors.tuna.tsinghua.edu.cn/centos-vault/5.11|' /etc/yum.repos.d/*.repo \
        && yum install -y \
            gcc glibc-devel glibc.i686 glibc-devel.i686 libgcc*.i386 \
            gcc-c++ libstdc++* libstdc++-devel.i686 \
            perl libidn autoconf automake libsysfs libtool make patch \
        && yum -y clean all \
        && cd /tmp \
            && tar -xf perl5-perl-5.10.1.tar.gz && cd perl5-perl-5.10.1 \
                && ./Configure -des -Dprefix=/usr/local && make -j4 && make install \
            && bash /tmp/cmake-3.2.3-Linux-x86_64.sh --prefix=/usr/local --exclude-subdir \
        && rm -rf /tmp/*

FROM centos:5

COPY --from=0 /usr/local /usr/local

RUN \
    sed -i 's/enabled=1/enabled=0/' /etc/yum/pluginconf.d/fastestmirror.conf \
        && sed -i 's/mirrorlist/#mirrorlist/' /etc/yum.repos.d/*.repo \
        && sed -i 's|#baseurl=http://mirror.centos.org/centos/$releasever|baseurl=http://mirrors.tuna.tsinghua.edu.cn/centos-vault/5.11|' /etc/yum.repos.d/*.repo \
        && yum install -y \
            gcc glibc-devel glibc.i686 glibc-devel.i686 libgcc*.i386 \
            gcc-c++ libstdc++* libstdc++-devel.i686  \
            perl libidn autoconf automake libsysfs libtool make patch zip unzip \
            valgrind tcpdump strace gdb \
        && yum -y clean all

CMD [ "/bin/bash" ]

