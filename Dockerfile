FROM centos:latest

MAINTAINER "EEA IDM-1" http://www.eea.europa.eu

RUN set -e \
        && yum -y install epel-release \
        && yum -y install xinetd \
        && yum -y install check-mk-agent-1.2.8p26-1.el7.x86_64 \
	&& mv /usr/share/check-mk-agent/available-plugins/mk_logwatch /usr/share/check-mk-agent/plugins/ \
        && yum clean all
COPY  logwatch.cfg /etc/check-mk-agent/

ENTRYPOINT [ "/usr/sbin/xinetd", "-f", "/etc/xinetd.conf", "-dontfork", "-stayalive" ]

