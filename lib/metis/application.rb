class Metis::Application
  def initialize(opts={})
    @options = opts
  end

  def run
    if @options[:daemonize]
      daemonize!
    else
      start
    end
  end

  def start
    # write pid file
    File.open(@options[:pid_file]) { |f| f.write(Process.pid.to_s) } if @options[:pid_file]

    # load context
    context = Metis::Context.new(@options[:config_file])
    context.load

    # fire up server
    server = Metis::Server.new(context)
    server.start
    server.run
  end

  def daemonize!
    raise 'Need to set a pid_file in order to daemonize!' unless @options[:pid_file]

    fork do
      Process.setsid
      exit if fork
      File.umask 0000
      STDIN.reopen "/dev/null"
      STDOUT.reopen "/dev/null", "a"
      STDERR.reopen STDOUT
      start
    end
  end
end
