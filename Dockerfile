FROM ubuntu:22.04

RUN apt update
RUN apt install -y openssh-server default-jre tree python3 sqlite3

RUN useradd -rm -d /home/ftp -s /bin/bash ftp
ARG password
RUN echo ftp:$password | chpasswd

RUN service ssh start
EXPOSE 22

RUN echo "export HISTTIMEFORMAT='%d/%m/%y %T '" >> /home/ftp/.bashrc

COPY ./data /home/ftp

COPY ./scripts/prepare_database.sh /tmp
ARG flag
RUN /tmp/prepare_database.sh /home/ftp/Documents/employees.db "$flag"
RUN rm -rf /tmp/prepare_database.sh

COPY ./Ransomware-Java/out/artifacts/ransomware.jar /tmp
RUN java -jar /tmp/ransomware.jar /home/ftp/Documents > /tmp/encrypt.log

COPY ./scripts/prepare_history.sh /tmp
RUN /tmp/prepare_history.sh /tmp/encrypt.log
RUN rm -rf /tmp/prepare_history.sh
RUN rm -rf /tmp/encrypt.log

RUN chown ftp:ftp -R /home/ftp

CMD /usr/sbin/sshd -D