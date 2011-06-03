class Metis::AgentContext
  include Clockwork

  attr_reader :host, :checks, :alerts

  def initialize
    @host = Metis::Host.new
    @host.all_plugins
    @checks = {}
    @alerts = []
  end

  def read_file(filename)
    if File.exists?(filename) && File.readable?(filename)
      dsl = Metis::Dsl::CheckDsl.new(self)
      dsl.instance_eval(IO.read(filename), filename, 1)
      @checks.merge!(dsl.checks)
    else
      raise IOError, "Cannot open or read #{filename}!"
    end
  end

  def start
    handler do |job|
      check = @checks[job]
      provider = check.class.provider_base.new(check, self)
      provider.execute if provider.prepare
      puts "WARNING!  HOST #{host.name} HAS ALERTS:\n#{@alerts.join("\n")}\n\n" unless @alerts.empty?
      @alerts.clear
    end

    @checks.values.each do |check|
      every check.every, check.name
    end

    run
  end

end
