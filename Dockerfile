FROM ubuntu:latest

RUN apt update
RUN apt upgrade -y
RUN apt install -y curl openssh-server

RUN systemctl start ssh
EXPOSE 22

COPY ./data /home/ftp

COPY ./scripts /tmp/scripts
RUN /tmp/scripts/encrypt.sh /home/ftp
RUN rm -rf /tmp/scripts

CMD bash