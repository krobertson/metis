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
  attr_reader :requires

  def initialize(name, host, params={})
    @name = name
    @host = host
    @params = params
    @requires = []
    implement_settings
  end

  def from_block(&block)
    resource = self.class.resource_type.new(self)
    resource.extend(Metis::Mixin::Requireable)
    resource.instance_eval(&block)
    @requires << resource.requires if resource.requires
  end

  def add_alert(message)
    @host.alerts << "Check '#{name}' raised alert: #{message}"
  end

  def _load_requires
    f = nil
    @requires.flatten.each { |r| f = r ; require r }
    true
  rescue LoadError
    add_alert("Failed to load: #{f}")
    false
  end

  def _execute
    execute if _load_requires
  rescue Exception => e
    add_alert(e.message)
  end

end
