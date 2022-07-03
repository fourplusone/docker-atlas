#!/bin/sh


export MVN_CMD="$(atlas-version | sed -ne 's/^Maven home: \(.*\)$/\1\/bin\/mvn/p') --batch-mode"
export ATLAS_MVN=/usr/bin/atlas-mvn-wrapper

atlas-run &
PID=$!

while [ -e /proc/$PID ]
do
echo "" | nc localhost 2990  && break
sleep 10
echo "========================== Waiting for server to start (PID: $PID) =========================="
done

echo "Sending KILL to $PID" 
kill $PID
