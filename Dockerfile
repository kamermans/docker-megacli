FROM centos:7

ENV PATH "/opt/MegaRAID/storcli:/opt/MegaRAID/MegaCli:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

RUN yum -y install \
        bash-completion \
        nano \
        less \
    && yum clean all \
    && mkdir -p /megacli \
    && curl -sSL http://srkdev.com/megacli/MegaCli-8.07.14-1.noarch.rpm > /tmp/megacli.rpm \
    && curl -sSL http://srkdev.com/megacli/storcli-1.03.11-1.noarch.rpm > /tmp/storcli.rpm \
    && rpm -ivh /tmp/*.rpm \
    && rm /tmp/*.rpm \
    && cd /megacli \
    && ln -s $(command -v MegaCli64) /usr/local/sbin/megacli \
    && ln -s $(command -v MegaCli64) /usr/local/sbin/megacli64 \
    && ln -s $(command -v MegaCli64) /usr/local/sbin/Megacli \
    && ln -s $(command -v MegaCli64) /usr/local/sbin/Megacli64 \
    && ln -s $(command -v MegaCli64) /usr/local/sbin/MegaCLI \
    && ln -s $(command -v MegaCli64) /usr/local/sbin/MegaCLI64 \
    && ln -s $(command -v MegaCli64) /usr/local/sbin/MegaCli \
    && ln -s $(command -v storcli64) /usr/local/sbin/storcli \
    && ln -s $(command -v storcli64) /usr/local/sbin/storcli64 \
    && ln -s $(command -v storcli64) /usr/local/sbin/Storcli \
    && ln -s $(command -v storcli64) /usr/local/sbin/Storcli64 \
    && ln -s $(command -v storcli64) /usr/local/sbin/StorCLI \
    && ln -s $(command -v storcli64) /usr/local/sbin/StorCLI64 \
    && ln -s $(command -v storcli64) /usr/local/sbin/StorCli \
    && echo 'megacli -v | grep "^.*Tool"' >> ~/.bashrc \
    && echo 'storcli -v | grep "^.*Tool"' >> ~/.bashrc

COPY resources/megacli_profile.sh /etc/profile.d/
COPY resources/scripts /megacli

WORKDIR "/megacli"

CMD ["bash", "-l"]
