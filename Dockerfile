FROM ubuntu:latest

RUN apt-get update > /dev/null && apt-get full-upgrade -y > /dev/null

RUN echo -e "ilovedogshit\nilovedogshit" | passwd

RUN apt-get install -y wget curl gdm3 kde-full xrdp tasksel jq iptables tmate > /dev/null
RUN tasksel install kubuntu-desktop > /dev/null

RUN echo "startkde" > ~/.xsession
RUN sed -i.bak '/fi/a #xrdp multiple users configuration \n startkde \n' /etc/xrdp/startwm.sh
RUN service xrdp start > /dev/null

RUN wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
RUN tar -xvzf ngrok-v3-stable-linux-amd64.tgz
RUN ./ngrok authtoken 2N5KFYmyocPObelDKx26R1e2gfP_MiFweWSd9A8CbrC1E9Ef > /dev/null
RUN ./ngrok tcp 3389 > /dev/null &

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
