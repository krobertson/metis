require 'socket'
require 'timeout'

class Metis::Runner::CheckPort < Metis::Runner
  def execute
    type = @params[:type] || :tcp
    port = @params[:port]
    timeout = @params[:timeout] || 10

    Timeout::timeout(timeout) do
      if type == :tcp
        TCPSocket.open(host[:ip_address], port)
      elsif type == :udp
        udp = UDPSocket.new
        udp.connect(host[:ip_address], port)
      end
    end
  end
end
