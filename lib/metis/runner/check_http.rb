require 'net/http'

class Metis::Runner::CheckHttp < Metis::Runner
  include Metis::Mixin::ConvertToClassName

  setting :timeout, :default => 10, :type => Fixnum
  setting :method,  :default => :get, :type => Symbol
  setting :path, :default => '/', :type => String
  setting :port, :default => 80, :type => Fixnum

  setting :status, :default => 200, :type => Fixnum
  setting :value, :type => [String, Regexp]

  def execute
    http = Net::HTTP.new(host[:ip_address], port)
    http.open_timeout = timeout
    http.read_timeout = timeout

    request = Net::HTTP.const_get(convert_to_class_name(method.to_s)).new(path)
    response = http.start {|http| http.request(request) }

    add_alert("Expected status #{status}, received #{response.code}") if status != response.code.to_i

    if value
      if value.is_a?(Regexp)
        add_alert("Expected regex was not met") unless value.match(response.body)
      else
        add_alert("Expected value not received") if response.body.chomp != value.to_s.chomp
      end
    end
  end
end
