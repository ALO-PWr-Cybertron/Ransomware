FROM python:3.7.14-buster

RUN apt update
RUN apt install -y openssh-server

RUN useradd -rm -d /home/ftp -s /bin/bash ftp
RUN echo 'ftp:ftp' | chpasswd

RUN service ssh start
EXPOSE 22

COPY ./data /home/ftp

COPY ./scripts/requirements.txt /tmp/scripts/
RUN pip install -r /tmp/scripts/requirements.txt

COPY ./scripts/encrypt.py /tmp/scripts/
RUN python /tmp/scripts/encrypt.py /home/ftp

RUN rm -rf /tmp/scripts

CMD /usr/sbin/sshd -D