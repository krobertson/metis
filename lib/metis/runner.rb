class Metis::Runner

  attr_reader :name
  attr_reader :host
  attr_reader :params

  def initialize(name, host, params={})
    @name = name
    @host = host
    @params = params
  end

  def add_alert(message)
    @host.alerts << "Check '#{name}' raised alert: #{message}"
  end

  def _execute
    execute
  rescue Exception => e
    add_alert(e.message)
  end

end
