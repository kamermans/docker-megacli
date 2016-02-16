FROM centos:7

ENV PATH "/opt/MegaRAID/MegaCli:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

ADD http://techedemic.com/wp-content/uploads/2015/10/8-07-14_MegaCLI.zip /tmp/megacli.zip

RUN yum -y update \
    && yum -y install \
        unzip \
        bash-completion \
        nano \
    && yum clean all \
    && cd /tmp \
    && unzip megacli.zip \
    && rpm -Uvh /tmp/Linux/MegaCli-*.rpm \
    && mkdir /megacli

WORKDIR "/megacli"

RUN echo 'TERM="xterm"' >> ~/.bashrc \
    && echo 'alias pico="nano"' >> ~/.bashrc \
    && ln -s $(command -v MegaCli64) /usr/local/sbin/megacli \
    && ln -s $(command -v MegaCli64) /usr/local/sbin/megacli64 \
    && ln -s $(command -v MegaCli64) /usr/local/sbin/Megacli \
    && ln -s $(command -v MegaCli64) /usr/local/sbin/Megacli64 \
    && ln -s $(command -v MegaCli64) /usr/local/sbin/MegaCLI \
    && ln -s $(command -v MegaCli64) /usr/local/sbin/MegaCLI64 \
    && ln -s $(command -v MegaCli64) /usr/local/sbin/MegaCli \
    && echo 'megacli -v' >> ~/.bashrc

CMD ["bash", "-l"]
