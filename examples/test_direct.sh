#!/bin/sh

amqpcat_bin="`dirname $0`/../bin/amqpcat"

url="amqp://guest:guest@rabbitmq/"
opts="--name=direct.test --type=direct"

## start 2 consumers ##
$amqpcat_bin -s "Consumer 1: " --consumer $url $opts &
$amqpcat_bin -s "Consumer 2: " --consumer $url $opts &

## send messages ##
echo "test direct queue: 1" | $amqpcat_bin --publisher $url $opts
echo "test direct queue: 2" | $amqpcat_bin --publisher $url $opts
echo "test direct queue: 3" | $amqpcat_bin --publisher $url $opts
echo "test direct queue: 4" | $amqpcat_bin --publisher $url $opts

## kill the consumers we forked ##
sleep 1
kill %1 %2
