require 'metis/mixin/params_validate'

class Metis
  class CheckDefinition
    include Metis::Mixin::ParamsValidate
    
    attr_accessor :name, :params
    
    def initialize
      @name = nil
      @params = {}
      @requires = []
    end

    def attribute(attr_name, validation_opts={})
      shim_method=<<-SHIM
      def #{attr_name}(arg=nil)
        set_or_return(:#{attr_name.to_s}, arg, #{validation_opts.inspect})
      end
      SHIM
      set_or_return(attr_name.to_sym, nil, validation_opts)
      self.instance_eval(shim_method)
    end

    def require_gem(*libs)
      @requires << libs
      @requires.flatten!
    end

    def execute(&block)
      set_or_return(:execute, block, :kind_of => [Proc])
    end

    def _requires
      @requires
    end

  end
end
