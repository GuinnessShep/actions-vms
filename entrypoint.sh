#!/bin/bash

# Start the tmate session and save the connection strings to a file
tmate -S /tmp/tmate.sock new-session -d
tmate -S /tmp/tmate.sock wait tmate-ready
tmate -S /tmp/tmate.sock display -p '#{tmate_ssh}' > /tmate_ssh
tmate -S /tmp/tmate.sock display -p '#{tmate_web}' > /tmate_web

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

tail -f /tmate.log
