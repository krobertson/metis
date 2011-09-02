class Metis::Application
  def initialize(opts={})
    @options = opts
    @context = Metis::Context.new(@options[:config_file])
    @context.configuration.daemonize true if @options[:daemonize]
  end

  def run
    if @context.configuration.daemonize
      daemonize!
    else
      start
    end
  end

  def start
    # write pid file
    File.open(@context.configuration.pid_file) { |f| f.write(Process.pid.to_s) } if @context.configuration.pid_file

    # load context
    @context.load

    # fire up server
    server = Metis::Server.new(@context)
    server.start
    server.run
  end

  def daemonize!
    raise 'Need to set a pid_file in order to fork!' unless @context.configuration.pid_file

    fork do
      Process.setsid
      exit if fork
      Dir.chdir @context.configuration.working_directory
      File.umask 0000
      STDIN.reopen "/dev/null"
      STDOUT.reopen "/dev/null", "a"
      STDERR.reopen STDOUT
      start
    end
  end
end
