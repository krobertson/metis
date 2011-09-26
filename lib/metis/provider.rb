class Metis
  class Provider
    attr_reader :definition, :response_code, :response_message

    def initialize(definition, context)
      @definition = definition
      @context = context
      @response_code = Metis::STATUS_OK
    end

    def params
      definition.params
    end

    def warn(msg)
      unless @response_code > Metis::STATUS_WARNING
        @response_code = Metis::STATUS_WARNING
        @response_message = msg
      end
    end

    def critical(msg)
      unless @response_code > Metis::STATUS_CRITICAL
        @response_code = Metis::STATUS_CRITICAL
        @response_message = msg
      end
    end

    def ok(msg=nil)
      unless @response_code > Metis::STATUS_OK
        @response_code = Metis::STATUS_OK
        @response_message = msg
      end
    end

    def run
      Timeout.timeout @context.configuration.timeout do
        result = self.instance_eval(&definition.execute) if prepare
      ok(result) if result.is_a?(String)
      end

    # catch a tmeout here... sometimes it can be raised here rather than in Client
    # want it caught here rather than the more general one so the message returned here
    # and from Client is ensured to be the same
    rescue Timeout::Error => e
      critical("The check timed out")

    rescue Exception => e
      critical("Exception raised: #{e.message}")
    end

    private

    def prepare
      f = nil
      definition._requires.each { |r| f = r ; require r }
      true
    rescue LoadError
      critical("Failed to load gem: #{f}")
      false
    end
  end
end
