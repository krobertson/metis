class Metis::Host

  attr_reader :name
  attr_reader :properties
  attr_reader :roles
  attr_reader :checks
  attr_reader :alerts

  def initialize(name, run_context=nil)
    @name = name
    @run_context = run_context

    @roles = []
    @checks = []
    @alerts = []
  end

  def [](key)
    @properties.params[key]
  end

  def from_block(&block)
    resource = Metis::WildcardDslResource.new(self)
    resource.extend(Metis::Mixin::Checkable)
    resource.extend(Metis::Mixin::Roleable)
    resource.instance_eval(&block)
    @properties = resource.params
    @checks << resource.checks if resource.checks
    @roles << resource.roles if resource.roles
  end
end
