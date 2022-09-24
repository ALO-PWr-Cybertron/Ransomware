FROM ubuntu:22.04

RUN apt update
RUN apt install -y openssh-server default-jre

RUN useradd -rm -d /home/ftp -s /bin/bash ftp
RUN echo 'ftp:ftp' | chpasswd

RUN service ssh start
EXPOSE 22

USER ftp

RUN echo "export HISTTIMEFORMAT='%d/%m/%y %T '" >> ~/.bashrc

COPY ./data /home/ftp

COPY ./Ransomware-Java/out/artifacts/ransomware.jar /tmp
RUN bash -c "java -jar /tmp/ransomware.jar /home/ftp/Documents"

USER root
CMD /usr/sbin/sshd -D