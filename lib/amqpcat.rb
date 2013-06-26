require 'uri'
require 'bunny'

class Amqpcat
  DEFAULT_QUEUE = 'amqpcat.default'

  def initialize(url, options={})
    parse_amqp_url(url)

    @opts = {
      :type => 'direct',
      :name => DEFAULT_QUEUE,
      :durable => true,
      :auto_delete => false,
      :ssl_key => nil,
      :ssl_cert => nil,
      :verify_ssl => true,
    }.merge(options)

    @amqp_settings.merge!(@opts)
    @amqp = Bunny.new(@amqp_settings)
    @amqp.start
  end

  def publish(msg)
    exchange.publish(msg)
  end

  def message_count
    queue.message_count
  end

  def fetch
    queue.pop[:payload]
  end

  def subscribe(&block)
    queue.subscribe(&block)
  end

  def finish
    @amqp.stop
  end

  private

  def parse_amqp_url(str)
    url = URI.parse(str)
    use_ssl = url.scheme.downcase == 'amqps'
    @amqp_settings = {
      :host => url.host,
      :port => url.port || (use_ssl ? 5671 : 5672),
      :user => url.user || 'guest',
      :pass => url.password || 'guest',
      :vhost => url.path == "" ? '/' : url.path,
      :ssl => use_ssl,
    }
  end

  def exchange
    return @exchange if @exchange
    options = {
      :type => @opts[:type],
      :durable => @opts[:durable],
      :auto_delete => @opts[:auto_delete]
    }
    @exchange = @amqp.exchange(@opts[:name], options)
  end

  def queue
    return @queue if @queue
    options = {
      :durable => @opts[:durable],
      :auto_delete => @opts[:auto_delete]
    }
    @queue = case @opts[:type]
    when 'fanout'
      @amqp.queue(options)
    else
      @amqp.queue(@opts[:name], options)
    end
    @queue.bind(exchange)
    @queue
  end
end
