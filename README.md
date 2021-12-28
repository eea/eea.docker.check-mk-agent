# check-mk-agent
Docker image is based on the community edition -  Check_MK Raw Edition
Docker container running check-mk-agent-2.0.0p3-1 and systemd.
Easily install check-mk-agent on docker hosts.
Base image - centos version 7.8.2003 and still using systemd.
Configuration for mk_docker plugin added.
Listen only on IPv4, TCP, port 6556.

# Usage example
docker run -it -d --name=check_mk-agent -p 6556:6556 eeacms/check-mk-agent:tag

# Build
docker build -t docker.check-mk-agent:2.0.0 .

# Run
docker run -d -it -p 6556:6556 -v /sys/fs/cgroup/:/sys/fs/cgroup:ro -v /var/run/docker.sock:/var/run/docker.sock --tmpfs /tmp --tmpfs /run --name checkmk docker.check-mk-agent:2.0.0
