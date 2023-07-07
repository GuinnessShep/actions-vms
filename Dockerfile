FROM ubuntu:latest

RUN apt-get update && apt-get install -y tmate wget curl gdm3 kde-full ubuntu-desktop xrdp tasksel jq

RUN echo "root:ilovedogshit" | chpasswd

RUN echo "startkde" > ~/.xsession
RUN sed -i.bak '/fi/a #xrdp multiple users configuration \n startkde \n' /etc/xrdp/startwm.sh
RUN service xrdp start > /dev/null

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
RUN tar -xvzf ngrok-v3-stable-linux-amd64.tgz
RUN ./ngrok authtoken 2N5KFYmyocPObelDKx26R1e2gfP_MiFweWSd9A8CbrC1E9Ef > /dev/null

ENTRYPOINT ["/entrypoint.sh"]
RUN ./ngrok tcp 3389
