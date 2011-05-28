require 'socket'
require 'timeout'

class Metis::Runner::CheckPort < Metis::Runner
  setting :timeout, :default => 10, :type => Fixnum
  setting :type, :default => :tcp, :type => Symbol
  setting :port, :default => 80, :type => Fixnum

  def execute
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
