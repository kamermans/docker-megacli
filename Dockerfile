FROM centos:7

ENV PATH "/opt/MegaRAID/storcli:/opt/MegaRAID/MegaCli:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ENV TERM xterm

RUN yum -y install \
        bash-completion \
        nano \
        less \
        dmidecode \
    && yum clean all \
    && rm -rf /var/cache/yum \
    && mkdir -p /megacli \
    && curl -sSL -o /tmp/megacli.rpm https://srkdev.com/megacli/MegaCli-8.07.14-1.noarch.rpm \
    && curl -sSL -o /tmp/storcli.rpm https://srkdev.com/megacli/storcli-1.03.11-1.noarch.rpm \
    && rpm -ivh /tmp/*.rpm \
    && rm /tmp/*.rpm \
    && curl -sSL -o /smartmontools.tar.gz http://builds.smartmontools.org/r4747/smartmontools-6.7-0-20180804-r4747.linux-x86_64-static.tar.gz \
    && cd / \
    && tar -zxf smartmontools.tar.gz \
    && rm smartmontools.tar.gz \
    && /usr/local/sbin/update-smart-drivedb \
    && curl -o /usr/local/bin/jq -sSL https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 \
    && chmod +x /usr/local/bin/jq \
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
