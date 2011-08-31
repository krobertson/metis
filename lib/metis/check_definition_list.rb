require 'metis/mixin/from_file'
require 'metis/check_definition'

class Metis
  class CheckDefinitionList
    include Metis::Mixin::FromFile

    attr_accessor :defines

    def initialize
      @defines = Hash.new
    end

    def define(check_name, &block)
      @defines[check_name] = CheckDefinition.new
      @defines[check_name].instance_eval(&block)
      true
    end
  end
end
