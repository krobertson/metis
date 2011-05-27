class Metis::Host

  attr_reader :name
  attr_reader :properties
  attr_reader :roles
  attr_reader :checks
  attr_reader :alerts

  def initialize(name, run_context=nil)
    @name = name
    @run_context = run_context

    @properties = Metis::Resource.new
    @properties.extend(Metis::Mixin::Checkable)
    @properties.extend(Metis::Mixin::Roleable)
    @roles = []
    @checks = []
    @alerts = []
  end

  def [](key)
    @properties.params[key]
  end

end
