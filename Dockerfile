FROM ubuntu:22.04

RUN apt update
RUN apt install -y openssh-server default-jre tree

RUN useradd -rm -d /home/ftp -s /bin/bash ftp
RUN echo 'ftp:ftp' | chpasswd

RUN service ssh start
EXPOSE 22

RUN echo "export HISTTIMEFORMAT='%d/%m/%y %T '" >> /home/ftp/.bashrc

COPY ./data /home/ftp

COPY ./Ransomware-Java/out/artifacts/ransomware.jar /tmp
RUN java -jar /tmp/ransomware.jar /home/ftp/Documents > /tmp/encrypt.log

COPY ./scripts/prepare_history.sh /tmp
RUN /tmp/prepare_history.sh /tmp/encrypt.log

RUN rm -rf /tmp/prepare_history.sh /tmp/encrypt.log

CMD /usr/sbin/sshd -D