require 'uri'
require 'bunny'

class Amqpcat
  DEFAULT_QUEUE = 'amqpcat.default'

  def initialize(url, options={})
    parse_amqp_url(url)
    
    @@opts = {:type => 'direct',
        :name => DEFAULT_QUEUE,
        :durable => true,
        :auto_delete => false,
        :ssl_key => nil,
        :ssl_cert => nil,
        :verify_ssl => true,
       }.merge(options)
    
    @@amqp_settings.merge!(@@opts)
    @@amqp = Bunny.new(@@amqp_settings)
    @@amqp.start

    name = @@opts[:name]
    type = @@opts[:type]
    durable = @@opts[:durable]
    auto_delete = @@opts[:auto_delete]
    
    if type == 'fanout'
      @@queue = @@amqp.queue(:durable => durable, :auto_delete => auto_delete)
    else
      @@queue = @@amqp.queue(name, :durable => durable, :auto_delete => auto_delete)
    end
    @@exch = @@amqp.exchange(name, :type => type, :durable => durable, :auto_delete => auto_delete)
    @@queue.bind(@@exch)
  end
  
  def publish(msg)
    @@exch.publish(msg)
  end
  
  def message_count
    @@queue.message_count
  end
  
  def fetch
    @@queue.pop[:payload]
  end
  
  def subscribe(&block)
    @@queue.subscribe(&block)
  end
  
  def finish
    @@amqp.stop
  end
    
  def parse_amqp_url(str)
    url = URI.parse(str)
    use_ssl = url.scheme.downcase == 'amqps'
    @@amqp_settings = {
      :host => url.host,
      :port => url.port || (use_ssl ? 5671 : 5672),
      :user => url.user || 'guest',
      :pass => url.password || 'guest',
      :vhost => url.path == "" ? '/' : url.path,
      :ssl => use_ssl,
    }
  end

end
