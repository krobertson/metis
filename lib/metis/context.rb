class Metis
  class Context

    attr_reader :definitions

    def initialize
      @definitions = Hash.new
    end

    def load
      load_checks
      load_configs
      true
    end

    def load_checks
      Dir.glob("checks/*.rb").each do |filename|
        checklist = Metis::CheckDefinitionList.new
        checklist.from_file(filename)
        definitions.merge!(checklist.defines) do |key, oldval, newval|
          puts "Overriding duplicate definition #{key}, new definition found in #{filename}"
          newval
        end
      end
    end
    
    def load_configs
      configdefinition = ConfigurationDefinition.new(self)
      configdefinition.from_file("config.rb")
    end
  end
end