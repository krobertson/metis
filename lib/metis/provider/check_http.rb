require 'net/http'

class Metis::Provider::CheckHttp < Metis::Provider
  def execute
    http = Net::HTTP.new(host[:ip_address], resource.port)
    http.open_timeout = resource.timeout
    http.read_timeout = resource.timeout

    request = Net::HTTP.const_get(convert_to_class_name(resource.method.to_s)).new(resource.path)
    response = http.start {|http| http.request(request) }

    add_alert("Expected status #{resource.status}, received #{response.code}") if resource.status != response.code.to_i

    if resource.value
      if resource.value.is_a?(Regexp)
        add_alert("Expected regex was not met") unless resource.value.match(response.body)
      else
        add_alert("Expected value not received") if response.body.chomp != resource.value.to_s.chomp
      end
    end
  end
end
