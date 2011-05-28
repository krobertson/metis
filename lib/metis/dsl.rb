class Metis
  class DSL

    attr_reader :context

    def initialize
      @context = Metis::SystemContext.new
    end

    def read_file(filename)
      if File.exists?(filename) && File.readable?(filename)
        self.instance_eval(IO.read(filename), filename, 1)
      else
        raise IOError, "Cannot open or read #{filename}!"
      end
    end

    def host(name, &block)
      resource = Metis::Host.new(name)
      resource.from_block(&block) if block
      @context.hosts[name] = resource
    end

    def role(name, &block)
      resource = Metis::Role.new(name)
      resource.from_block(&block) if block
      @context.roles[name] = resource
    end

    def method_missing(method_name, *args, &block)
      @context.checks[args.first] = { :name => args.first, :type => method_name, :args => args.pop, :block => block }
    end

  end
end