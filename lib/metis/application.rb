class Metis::Application
  def initialize(opts={})
    @options = opts
  end

  def run
    context = Metis::Context.new(@options[:config_file])
    context.load

    server = Metis::Server.new context
    server.start
    server.run
  end
end
