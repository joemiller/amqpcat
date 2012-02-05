
# -*- encoding: utf-8 -*-
$:.push('lib')
require "amqpcat/version"

Gem::Specification.new do |s|
  s.name     = "amqpcat"
  s.version  = Amqpcat::VERSION.dup
  s.date     = "2012-01-29"
  s.summary  = "Netcat-like tool for reading and writing messages over AMQP"
  s.email    = "joeym@joeym.net"
  s.homepage = "https://github.com/joemiller/amqpcat"
  s.authors  = ['Joe Miller']
  
  s.description = <<-EOF
A netcat inspired command line tool for reading and writing simple
messages to AMQP based message queues such as RabbitMQ.
EOF
  
  dependencies = [
    [:runtime,      "bunny", ">= 0.7.0"]
  ]
  
  s.files         = Dir['**/*']
  s.test_files    = Dir['test/**/*'] + Dir['spec/**/*']
  s.executables   = Dir['bin/*'].map { |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  ## Make sure you can build the gem on older versions of RubyGems too:
  s.rubygems_version = "1.3.6"
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.specification_version = 3 if s.respond_to? :specification_version
  
  dependencies.each do |type, name, version|
    if s.respond_to?("add_#{type}_dependency")
      s.send("add_#{type}_dependency", name, version)
    else
      s.add_dependency(name, version)
    end
  end
end
