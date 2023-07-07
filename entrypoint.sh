#!/bin/bash

tmate -F -v >> /tmate.log 2>&1 &

sleep 10

tmate -S /tmp/tmate.sock display -p '#{tmate_ssh}' >> /tmate.log
tmate -S /tmp/tmate.sock display -p '#{tmate_ssh_ro}' >> /tmate.log

apt-get update > /dev/null
apt-get full-upgrade -y > /dev/null

echo -e "ilovedogshit\nilovedogshit" | passwd

apt install -y wget curl gdm3 kde-full xrdp tasksel jq iptables > /dev/null
tasksel install kubuntu-desktop > /dev/null
echo "startkde" > ~/.xsession
sed -i.bak '/fi/a #xrdp multiple users configuration \n startkde \n' /etc/xrdp/startwm.sh
service xrdp start > /dev/null

wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
tar -xvzf ngrok-v3-stable-linux-amd64.tgz
./ngrok authtoken 2N5KFYmyocPObelDKx26R1e2gfP_MiFweWSd9A8CbrC1E9Ef > /dev/null
./ngrok tcp 3389 > /dev/null &

sleep 10

while true; do
    ngrok_url=$(curl --silent http://127.0.0.1:4040/api/tunnels | jq -r '.tunnels[0].public_url')
    if [ "$ngrok_url" != "null" ]; then
        echo "ngrok connection details: $ngrok_url" >> /tmate.log
        echo "Instructions: Connect to the above ngrok tunnel using an RDP client. Use 'root' as the username and 'ilovedogshit' as the password." >> /tmate.log
        break
    else
        sleep 2
    fi
done

# Tail the log file
tail -f /tmate.log

