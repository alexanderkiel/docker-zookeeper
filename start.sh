#!/bin/sh

if [ -z $ZK_SERVERS ]; then
    echo "ZK_SERVERS expected."
    exit 1
fi
if [ -z $ZK_SERVER_NUMBER ]; then
    echo "ZK_SERVER_NUMBER expected."
    exit 1
fi

ZOOKEEPER_DIR=/zookeeper-3.4.6
DATA_DIR=/var/lib/zookeeper
OIFS=$IFS
IFS=','
ID=1
for SERVER in $ZK_SERVERS
do
  if [ $ID -eq $ZK_SERVER_NUMBER ]; then
     SERVER="0.0.0.0"
  fi
  echo "server.$ID=$SERVER:2888:3888" >> $ZOOKEEPER_DIR/conf/zoo.cfg
  ID=$(expr $ID + 1)
done
IFS=$OIFS

echo "ZooKeeper Config:"
cat $ZOOKEEPER_DIR/conf/zoo.cfg

echo "Building myid as server $ZK_SERVER_NUMBER"
echo $ZK_SERVER_NUMBER > $DATA_DIR/myid
echo "Starting zookeeper server $(cat $DATA_DIR/myid)"

$ZOOKEEPER_DIR/bin/zkServer.sh start-foreground
