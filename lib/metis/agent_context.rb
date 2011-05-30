require 'clockwork'

class Metis::AgentContext
  include Clockwork

  attr_reader :host, :checks

  def initialize
    @host = Metis::H2.new
    @host.all_plugins
    @checks = {}
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

  def begin
    handler do |job|
      check = @checks[job]
      provider = check.class.provider_base.new(check, self)
      provider.execute if provider.prepare
      puts "WARNING!  HOST #{host.name} HAS ALERTS:\n#{host.alerts.join("\n")}\n\n" unless host.alerts.empty?
      host.alerts.clear
    end

    @checks.values.each do |check|
      every check.every, check.name
    end

    run
  end

end
