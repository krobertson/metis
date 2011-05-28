class Metis::Resource::CheckPort < Metis::Resource
  provider_base Metis::Provider::CheckPort

  def initialize(name, context=nil)
    super
    @timeout = 10
    @type    = :tcp
  end

  def timeout(arg=nil)
    set_or_return(
      :timeout,
      arg,
      :kind_of => [ Fixnum ]
    )
  end

  def type(arg=nil)
    set_or_return(
      :type,
      arg,
      :kind_of => [ Symbol ]
    )
  end

  def port(arg=nil)
    set_or_return(
      :port,
      arg,
      :kind_of => [ Fixnum ]
    )
  end

end
