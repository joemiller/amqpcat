amqpcat - Netcat-like tool for AMQP queues
==========================================

This was originally written as a "toy" to learn and experiment with
rabbitmq. It allows you to easily read/write from AMQP queues/exchanges
from the command line or from shell scripts. It is implemented with the
`bunny` Ruby gem.

Install
-------
Install from gem:

    sudo gem install amqpcat

Install from github:

    git clone https://github.com/joemiller/amqpcat
    gem build amqpcat.gemspec
    gem install amqpcat-0.0.1.gem

Example Usage
-------------

### 1:1 Messaging

Start a consumer. This will block until a message is received.

    amqpcat --consumer amqp://guest:guest@rabbitmq.server/

Publish a message:

    echo "hello rabbit" | amqpcat --publisher amqp://guest:guest@rabbitmq.server/

The consumer should output the message and exit.

### 1:N (fanout / pubsub)

See the `examples/test_fanout.sh` script for another example of fanout
messaging.

Start 2 consumers, using `-s` to prefix the output of each with an
identifying string:

    amqpcat --consumer -n fanout.test -t fanout -s "Consumer 1: " amqp://guest:guest@rabbitmq.server/
    amqpcat --consumer -n fanout.test -t fanout -s "Consumer 2: " amqp://guest:guest@rabbitmq.server/

Note: In fanout mode, consumers will create their own server-named queues and bind to an exchange
defined by the `-n` parameter.

Published a message to the exchange:

    echo "hello rabbits" | amqpcat --publisher -n fanout.test -t fanout amqp://guest:guest@rabbitmq.server/

Both of the consumers should print out the message we published.

Options
-------
Run `amqpcat -h` to get detailed help output.

### One-message -vs- Continuous message mode

By default, when publishing, `amqpcat` will use the newline character to 
distinguish between messages to publish. However, you can send a single
message by using the `--once` option. This can be useful if you need
to send a single message that contains new lines.

SSL Support
-----------
SSL support has been written but is not tested nor is it fully working
at this time (v0.0.1).
 
Additionally, the --ssl-key and --ssl-cert options are only supported 
under newer versions of the Bunny gem (0.8+) or if bunny is installed
from the master branch on github.

Contributing
------------
1. Fork it.
2. Create a branch (`git checkout -b my_feature`)
3. Commit your changes (`git commit -am "did some stuff"`)
4. Push to the branch (`git push origin my_feature`)
5. Create an with a link to your branch

Author
------

Joe Miller - http://twitter.com/miller_joe || https://github.com/joemiller

License
-------

    Author:: Joe Miller (<joeym@joeym.net>)
    Copyright:: Copyright (c) 2012 Joe Miller
    License:: Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.