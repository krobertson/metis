class Metis::Provider::Check < Metis::Provider
  def execute
    resource.execute.call
  end
end
