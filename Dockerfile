FROM centos:7

ENV PATH "/opt/MegaRAID/MegaCli:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

RUN yum -y install \
        unzip \
        bash-completion \
        nano \
        less \
    && yum clean all \
    && mkdir -p /tmp/mega /megacli \
    && cd /tmp \
    && curl -sSL http://srkdev.com/megacli/8-07-14_MegaCLI.zip > /tmp/megacli.zip \
    && unzip megacli.zip \
    && rpm -Uvh /tmp/Linux/MegaCli-*.rpm \
    && cd /megacli \
    && rm -rf /tmp/mega \
    && ln -s $(command -v MegaCli64) /usr/local/sbin/megacli \
    && ln -s $(command -v MegaCli64) /usr/local/sbin/megacli64 \
    && ln -s $(command -v MegaCli64) /usr/local/sbin/Megacli \
    && ln -s $(command -v MegaCli64) /usr/local/sbin/Megacli64 \
    && ln -s $(command -v MegaCli64) /usr/local/sbin/MegaCLI \
    && ln -s $(command -v MegaCli64) /usr/local/sbin/MegaCLI64 \
    && ln -s $(command -v MegaCli64) /usr/local/sbin/MegaCli \
    && echo 'megacli -v' >> ~/.bashrc

COPY resources/megacli_profile.sh /etc/profile.d/
COPY resources/scripts /megacli

WORKDIR "/megacli"

CMD ["bash", "-l"]
