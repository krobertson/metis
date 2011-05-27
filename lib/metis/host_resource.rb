class Metis::HostResource < Metis::Resource
  attr_reader :host

  def initialize(host)
    @host = host
  end
end
    