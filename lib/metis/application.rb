class Metis::Application
  def initialize(options={})
    @context = options[:context_class].new
    @context.read_file(options[:config_file])
  end

  def run
    @context.start
  end
end
