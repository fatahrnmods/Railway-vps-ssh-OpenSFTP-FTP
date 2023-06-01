FROM kalilinux/kali-linux

RUN apt-get update -y > /dev/null 2>&1 && apt-get upgrade -y > /dev/null 2>&1 && apt-get install locales -y \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && apt-get install ssh wget unzip openssh-server -y > /dev/null 2>&1

RUN wget -O ngrok.zip https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.zip > /dev/null 2>&1 \
    && unzip ngrok.zip

RUN echo "./ngrok authtoken 2LwTiGqixdYcVOR8PqEW0t25Kne_7zQ7YNWqPc9dtd1LdkKh6 &&" >>/1.sh \
    && echo "./ngrok tcp --region=sg 22 &>/dev/null &" >>/1.sh \
    && echo 'mkdir -p /run/sshd' >>/1.sh \
    && echo '/usr/sbin/sshd -D' >>/1.sh \
    && echo 'echo "By Radhin Development"' >> /1.sh

RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
    && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config \
    && echo root:110207|chpasswd

RUN service ssh start

RUN chmod 755 /1.sh

EXPOSE 22 80 8888 8080 443 5130 5131 5132 5133 5134 5135 3306

CMD  /1.sh
