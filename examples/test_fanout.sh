#!/bin/sh

amqpcat_bin="`dirname $0`/../bin/amqpcat"

amqp_url="amqp://guest:guest@rabbitmq/"
amqp_opts="--name=fanout.test --type=fanout"

## start 2 consumers ##
$amqpcat_bin -s "Consumer 1: " $amqp_url $amqp_opts &
$amqpcat_bin -s "Consumer 2: " $amqp_url $amqp_opts &
sleep 1

## send messages ##
echo "test fanout queue: 1" | $amqpcat_bin $amqp_url $amqp_opts
echo "test fanout queue: 2" | $amqpcat_bin $amqp_url $amqp_opts
echo "test fanout queue: 3" | $amqpcat_bin $amqp_url $amqp_opts
echo "test fanout queue: 4" | $amqpcat_bin $amqp_url $amqp_opts

## kill the consumers we forked ##
sleep 1
kill %1 %2
