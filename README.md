amqpcat - Netcat-like tool for AMQP queues
==========================================

This was originally written as a "toy" to learn and experiment with rabbitmq.
It allows you to easily read/write from AMQP queues/exchanges from the command
line or from shell scripts. It is implemented with the `bunny` Ruby gem.

Install
=======

todo

Example Usage
=============

- 1:1
- 1:N (fanout)
- single message
- continuous messaging

Options
=======

SSL
===
todo

Contributing
===========
todo

License
=======
todo


-----------
todo
----
- gemify
x implement durable and autodelete  (autodelete=true, durable=false defaults?)
x fix fanout test (not sending to all consumers)
x writer should read continuously from input and break on newline
x implement '--once' on reader and writer modes
- get rid of debug output
- logger/debug output?
x make gem (gemspec), do dirs
x get rid of need for require_relative
x cleanup old files
x fix examples to be non-specific to my VM
x deal with ssl client key + cert (env vars? command line opts?)
