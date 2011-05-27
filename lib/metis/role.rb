class Metis::Role

  attr_reader :properties

  def initialize(name, run_context=nil)
    @name = name
    @run_context = run_context

    @properties = Metis::Resource.new
    @properties.extend(Metis::Mixin::Checkable)
    @properties.extend(Metis::Mixin::Roleable)
  end

end
