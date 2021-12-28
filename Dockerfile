# FROM centos:7.8.2003
# run command:  docker run -it -d -v /sys/fs/cgroup/:/sys/fs/cgroup:ro --cap-add SYS_ADMIN --name centos centos/systemd /bin/bash
# might need to add --tmpfs /tmp --tmpfs /run, but remove --cap-add SYS_ADMIN

# docker run -d -it -p 6556:6556 -v /sys/fs/cgroup/:/sys/fs/cgroup:ro -v /var/run/docker.sock /var/run/docker.sock --tmpfs /tmp --tmpfs /run --name centos centos/systemd

# docker build -t docker.check-mk-agent:2.0.0 .
FROM centos/systemd:latest

LABEL name="check_mk_agent" \
      maintainer="Mike Pflugfelder <mikepflu@gmail.com>" \
      app_repository="https://github.com/mikepflu/eea.docker.check-mk-agent.git"

ARG rpmfile=check-mk-agent-2.0.0p3-1.noarch.rpm

COPY files /files

RUN set -e \
        && /usr/bin/yum -y install epel-release \
        && chmod 740 /files/$rpmfile \
        && rpm -ivf /files/$rpmfile --noscripts \
        && yum upgrade -y \
        && yum -y install docker python3 python3-pip \
        && pip3 install --upgrade pip \
        && pip3 install pathlib docker \
        && yum clean all \
        # && cp /files/mk_logwatch_2.py /usr/lib/check_mk_agent/plugins/ \
        && cp /files/mk_docker.py /usr/lib/check_mk_agent/plugins/ \
        # && cp /files/logwatch.cfg /etc/check_mk/ \
        && cp /files/docker.cfg /etc/check_mk/ \
        #&& cp /files/mk_logins /usr/lib/check_mk_agent/plugins/ \
        && chmod 744 -R /usr/lib/check_mk_agent/plugins/ \
        && ln -s /etc/systemd/system/check_mk.socket /etc/systemd/system/sockets.target.wants/check_mk.socket \
        && rm -rf /files

EXPOSE 6556/tcp
