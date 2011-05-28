class Metis::Provider::CheckTrue < Metis::Provider
  def execute
    result = resource.execute.call
    add_alert("Returned #{result.inspect}") unless result
  end
end
