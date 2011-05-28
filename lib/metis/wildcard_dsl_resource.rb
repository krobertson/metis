class Metis::WildcardDslResource
  attr_accessor :params

  def initialize(parent)
    @parent = parent
  end

  def method_missing(method_name, *args)
    @params ||= {}
    @params[method_name] = args.first
  end
end
