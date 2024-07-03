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
        && wget https://releases.linaro.org/components/toolchain/binaries/4.9-2016.02/aarch64-linux-gnu/gcc-linaro-4.9-2016.02-x86_64_aarch64-linux-gnu.tar.xz \
        && xz -d gcc-linaro-4.9-2016.02-x86_64_aarch64-linux-gnu.tar.xz \
        && tar -xvf gcc-linaro-4.9-2016.02-x86_64_aarch64-linux-gnu.tar -C /opt/ \
    && rm -rf /tmp/*

CMD [ "/bin/bash" ]

