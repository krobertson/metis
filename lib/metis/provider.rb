class Metis
  class Provider
    attr_reader :definition
    
    def initialize(definition)
      @definition = definition
    end

    def params
      definition.params
    end

    def warn(msg)
      puts msg
    end
    
    def critical(msg)
      puts msg
    end
    
    def ok(msg=nil)
      puts msg
    end

    def run
      self.instance_eval(&definition.execute) if prepare
    end

    private

    def prepare
      f = nil
      definition._requires.each { |r| f = r ; require r }
      true
    rescue LoadError
      critical("Failed to load: #{f}")
      false
    end
  end
end