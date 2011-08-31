class Metis::Client

  def initialize(socket, context)
    @socket = socket
    @context = context
  end
  
  def process
    query = Metis::NrpePacket.read(@socket)

    # ensure it doesn't specify any commands
    if query.buffer =~ /!/
      send_response(Metis::STATUS_CRITICAL, "Arguments not allowed")
      return
    end

    # find the command
    check_name = query.buffer.to_sym
    check_definition = @context.definitions[check_name]

    # ensure it exists
    unless check_definition
      send_response(Metis::STATUS_WARNING, "Command #{query.buffer} not found")
      return
    end

    # run it
    provider = Metis::Provider.new(check_definition)
    provider.run
    send_response(provider.response_code, provider.response_message)

  ensure
    @socket.close
  end

  private
  
  def send_response(result_code, message)
    response = Metis::NrpePacket.new
    response.packet_type = :response
    response.result_code = result_code
    response.buffer = message
    @socket.write(response.to_bytes)
    true
  end

end