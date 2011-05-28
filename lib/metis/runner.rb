class Metis::Runner
  extend Metis::Mixin::ClassSettings
  include Metis::Mixin::InstanceSettings

  class << self
    def resource_type(type=nil)
      @@resource_type = type if type
      @@resource_type
    end
  end

  resource_type Metis::DslResource

  attr_reader :name
  attr_reader :host
  attr_reader :params

  def initialize(name, host, params={})
    @name = name
    @host = host
    @params = params
    implement_settings
  end

  def from_block(&block)
    resource = self.class.resource_type.new(self)
    resource.instance_eval(&block)
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
