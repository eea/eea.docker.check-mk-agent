# eea.docker.check-mk-agent
Docker image is based on the community edition -  Check_MK Raw Edition
Docker container running check_mk_agent-1.60p12 and xinetd.
Easily install check-mk-agent on docker hosts.
Base image - centos version 7.8.2003 and still using xinetd.
Configuration for logwatch plugin added.
Listen only on IPv4, TCP, port 6556.
# Usage example
docker run -it -d --name=check_mk-agent -p 6556:6556 eeacms/check-mk-agent
