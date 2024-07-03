FROM centos:8

RUN \
    sed -i 's/mirrorlist=/#mirrorlist=/g' /etc/yum.repos.d/CentOS-*.repo \
    && sed -i 's/#baseurl=http:\/\/mirror.centos.org/baseurl=https:\/\/mirrors.aliyun.com/g' /etc/yum.repos.d/CentOS-*.repo \
    && echo "export LC_ALL=C" >> /etc/profile && source /etc/profile \
    && yum install -y \
        unzip \
	    cmake autoconf automake make patch \
    && yum -y clean all \
    && cd /tmp \
        && curl -O https://dl.google.com/android/repository/android-ndk-r16b-linux-x86_64.zip \
        && unzip android-ndk-r16b-linux-x86_64.zip -d /opt/ \
        && rm -f android-ndk-r16b-linux-x86_64.zip

CMD [ "/bin/bash" ]

