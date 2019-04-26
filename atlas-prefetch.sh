#!/bin/sh

atlas-run-standalone  $@ --http-port 9090 &
PID=$!

while [ -e /proc/$PID ]
do
echo "" | nc localhost 9090  && break
sleep 10
echo "========================== Waiting for server to start (PID: $PID) =========================="
done

echo "Sending KILL to $PID" 
kill $PID