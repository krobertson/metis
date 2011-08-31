require 'socket'
require 'openssl'

class Metis::Server

  DEFAULT_OPTIONS = {
                      :host => '0.0.0.0',
                      :port => 5667,
                      :enable_ssl => true
                    }

  def initialize(context, options={})
    @context = context
    @options = DEFAULT_OPTIONS.merge(options)

    if @options[:enable_ssl]
      @ssl_context = OpenSSL::SSL::SSLContext.new "SSLv23_server"
      @ssl_context.ciphers = 'ADH'
    end
  end

  def start
    @server = TCPServer.new(@options[:host], @options[:port])
    @server = OpenSSL::SSL::SSLServer.new(@server, @ssl_context) if @options[:enable_ssl]
    true
  end

  def stop
    @server.stop if @server
  end

  def run
    client_socket = @server.accept
    fork {
      client = Metis::Client.new(client_socket, @context)
      client.process
    }
  end

end