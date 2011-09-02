class Metis
  class Context

    attr_reader :definitions, :configuration

    def initialize(configuration_file=nil)
      @definitions = Hash.new

      @configuration = Metis::Configuration.new
      @configuration.from_file(configuration_file) if configuration_file && File.exists?(configuration_file)
    end

    def load
      Dir.chdir @configuration.working_directory
      load_checks
      load_check_config
      true
    end

    def load_checks
      @configuration.checks_include_directories.each do |dir|
        Dir.glob(File.join(dir, "**/*.rb")).each do |filename|
          next if @configuration.ignore_filename_patterns.detect { |p| filename =~ p }

          checklist = Metis::CheckDefinitionList.new
          checklist.from_file(filename)

          definitions.merge!(checklist.defines) do |key, oldval, newval|
            puts "Overriding duplicate definition #{key}, new definition found in #{filename}"
            newval
          end
        end
      end
    end

    def load_check_config
      if File.exists?(@configuration.check_configuration_file)
        configdefinition = ConfigurationDefinition.new(self)
        configdefinition.from_file(@configuration.check_configuration_file)
      end
    end
  end
end
