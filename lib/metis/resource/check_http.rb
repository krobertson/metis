class Metis::Resource::CheckHttp < Metis::Resource
  provider_base Metis::Provider::CheckHttp

  def initialize(name, context=nil)
    super
    @timeout = 10
    @method  = :get
    @path    = '/'
    @port    = 80
    @status  = 200
  end

  def timeout(arg=nil)
    set_or_return(
      :timeout,
      arg,
      :kind_of => [ Fixnum ]
    )
  end

  def method(arg=nil)
    set_or_return(
      :method,
      arg,
      :kind_of => [ Symbol, String ]
    )
  end

  def path(arg=nil)
    set_or_return(
      :path,
      arg,
      :kind_of => [ String ]
    )
  end

  def port(arg=nil)
    set_or_return(
      :port,
      arg,
      :kind_of => [ Fixnum ]
    )
  end

  def status(arg=nil)
    set_or_return(
      :status,
      arg,
      :kind_of => [ Fixnum ]
    )
  end

  def value(arg=nil)
    set_or_return(
      :value,
      arg,
      :kind_of => [ String, Regexp ]
    )
  end

end
