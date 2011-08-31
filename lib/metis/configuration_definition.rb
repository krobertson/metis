require 'metis/mixin/from_file'

class Metis
  class ConfigurationDefinition
    include Metis::Mixin::FromFile    

    def initialize(context)
      @context = context
    end

    def configure(check_name, &block)
      raise "Unknown check definition: #{check_name}" unless @context.definitions[check_name]
      @context.definitions[check_name].instance_eval(&block)
      true
    end
  end
end
