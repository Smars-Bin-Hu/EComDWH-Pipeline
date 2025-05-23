#!/bin/bash

# source the environment variable PATH
export PATH=/usr/local/opt/module/zookeeper/bin:/usr/local/opt/module/sqoop/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/opt/module/hadoop/bin:/usr/local/opt/module/hadoop/sbin:/usr/local/opt/module/hive/bin

PORT=9100
MAX_WAIT=120
COUNT=0

echo "stop node-exporter on hadoop-worker1 container"
netstat -nltp | grep ':9100' | awk '{print $7}' | cut -d'/' -f1 | xargs -r kill -15

while true; do
  if ! nc -z localhost $PORT; then
      echo "hadoop-worker1 container: port 9100 is already down"
      echo "hadoop-worker1 container: successfully stop node-exporter on hadoop-worker1 container"
      break
    fi
    sleep 1
    COUNT=$((COUNT+1))
    if [ $COUNT -ge $MAX_WAIT ]; then
      echo "hadoop-worker1 container: Timeout"
      echo "hadoop-worker1 container: FAILED to stop node-exporter on hadoop-worker1 container"
      exit 1
    fi
done