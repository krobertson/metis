require 'socket'
require 'timeout'

class Metis::Provider::CheckPort < Metis::Provider
  def execute
    Timeout::timeout(resource.timeout) do
      if resource.type == :tcp
        socket = TCPSocket.open(host[:ip_address], resource.port)
        socket.close
      elsif resource.type == :udp
        udp = UDPSocket.new
        udp.connect(host[:ip_address], resource.port)
      end
    end
  end
end
