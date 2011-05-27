require 'net/http'

class Metis::Runner::CheckHttp < Metis::Runner
  include Metis::Mixin::ConvertToClassName

  def execute
    method = @params[:method] || :get
    path = @params[:path] || '/'
    port = @params[:port] || 80
    timeout = @params[:timeout] || 10

    status = @params[:status] || 200
    value = @params[:value]

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
