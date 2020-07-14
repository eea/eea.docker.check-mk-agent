FROM centos:7.8.2003

MAINTAINER "EEA IDM-1" http://www.eea.europa.eu

RUN set -e \
        && /usr/bin/yum -y install epel-release \
        && /usr/bin/yum -y install xinetd \
	&& /usr/bin/curl -k -L https://github.com/eea/eea.docker.check-mk-agent/blob/master/files/check-mk-agent-1.6.0p12-1.noarch.rpm \
	&& /usr/bin/chmod +x check-mk-agent-1.6.0p12-1.noarch.rpm \
        && yum -y install check-mk-agent-1.6.0p12-1.noarch.rpm \
        && yum clean all \
	&& /usr/bin/curl -k -L https://github.com/eea/eea.docker.check-mk-agent/blob/master/files/mk_logwatch \
	&& /usr/bin/curl -k -L https://github.com/eea/eea.docker.check-mk-agent/blob/master/files/mk_logins
copy  mk_logwatch /usr/lib/check_mk_agent/plugins/
COPY  check-mk-agent /etc/xinetd.d/check_mk
COPY  logwatch.cfg /etc/check_mk/

ENTRYPOINT [ "/usr/sbin/xinetd", "-f", "/etc/xinetd.conf", "-dontfork", "-stayalive" ]
