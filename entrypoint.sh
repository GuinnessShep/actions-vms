#!/bin/bash
tmate -F -v >> /tmate.log 2>&1 &

sleep 10

tmate -S /tmp/tmate.sock display -p '#{tmate_ssh}' >> /tmate.log
tmate -S /tmp/tmate.sock display -p '#{tmate_ssh_ro}' >> /tmate.log

tail -f /tmate.log
