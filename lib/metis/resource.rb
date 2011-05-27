class Metis::Resource

  include Metis::Mixin::Parameterized

  attr_reader :not_if_args
  attr_reader :only_if_args

  def initialize
    @params = {}

    @not_if = nil
    @not_if_args = {}
    @only_if = nil
    @only_if_args = {}
  end

  def only_if(arg=nil, args = {}, &blk)
    if Kernel.block_given?
      @only_if = blk
      @only_if_args = args
    else
      @only_if = arg if arg
      @only_if_args = args if arg
    end
    @only_if
  end

  def not_if(arg=nil, args = {}, &blk)
    if Kernel.block_given?
      @not_if = blk
      @not_if_args = args
    else
      @not_if = arg if arg
      @not_if_args = args if arg
    end
    @not_if
  end

end
