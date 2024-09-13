FROM centos:8

RUN \
    sed -i 's/mirrorlist=/#mirrorlist=/g' /etc/yum.repos.d/CentOS-*.repo \
    && sed -i 's/#baseurl=http:\/\/mirror.centos.org/baseurl=https:\/\/mirrors.aliyun.com/g' /etc/yum.repos.d/CentOS-*.repo \
    && yum install -y \
        gcc glibc-devel glibc.i686 glibc-devel.i686 \
        gcc-c++ libstdc++-devel libstdc++-devel.i686 \
	    cmake autoconf automake make patch \
	    valgrind tcpdump strace gdb \
	    diffutils perl \
    && yum -y clean all

CMD [ "/bin/bash" ]

