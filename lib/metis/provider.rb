class Metis::Provider
  attr_accessor :resource, :context

  def initialize(resource, context)
    @resource = resource
    @context = context
  end

  def host
    @context.host
  end

  def add_alert(message)
    @context.alerts << message
  end

  def prepare
    f = nil
    resource._requires.each { |r| f = r ; require r }
    true
  rescue LoadError
    add_alert("Failed to load: #{f}")
    false
  end
end
