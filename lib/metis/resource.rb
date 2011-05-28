class Metis::Resource
  include Metis::Mixin::ParamsValidate

  attr_reader :name
  attr_reader :context

  def initialize(name, context=nil)
    @name = name
    @context = context
    @requires = []
    @alerts = []
  end

  def host
    @context.host
  end

  def include_require(*libs)
    @requires << libs
    @requires.flatten!
  end

  def add_alert(message)
    @alerts << message
  end

  def _requires
    @requires
  end

  class << self
    def provider_base(arg=nil)
      @provider_base ||= arg
      @provider_base ||= Metis::Provider
    end
  end

end