FROM centos:8

RUN \
    sed -i 's/mirrorlist=/#mirrorlist=/g' /etc/yum.repos.d/CentOS-*.repo \
    && sed -i 's/#baseurl=http:\/\/mirror.centos.org/baseurl=https:\/\/mirrors.aliyun.com/g' /etc/yum.repos.d/CentOS-*.repo \
    && echo "export LC_ALL=C" >> /etc/profile && source /etc/profile \
    && yum install -y \
        wget \
        perl cmake autoconf automake make patch \
    && yum -y clean all \
    && cd /tmp \
        && wget https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-a/8.3-2019.03/binrel/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu.tar.xz \
        && xz -d gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu.tar.xz \
        && tar -xvf gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu.tar -C /opt/ \
    && rm -rf /tmp/*

CMD [ "/bin/bash" ]

