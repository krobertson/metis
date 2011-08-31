class Metis::Configuration
  include Metis::Mixin::FromFile
  include Metis::Mixin::ParamsValidate

  attr_reader :params

  def initialize
    @params = {}
  end

  def working_directory(arg=nil)
    set_or_return(
      :working_directory,
      arg,
      :kind_of => String, :default => Dir.pwd
    )
  end

  def checks_include_directories(*arg)
    set_or_return(
      :checks_include_directories,
      arg.empty? ? nil : arg,
      :kind_of => Array, :default => ['checks']
    )
  end

  def ignore_filename_patterns(*arg)
    set_or_return(
      :ignore_filename_patterns,
      arg.empty? ? nil : arg,
      :kind_of => Array, :default => [ /_spec.rb$/ ]
    )
  end

  def check_configuration_file(arg=nil)
    set_or_return(
      :check_configuration_file,
      arg,
      :kind_of => String, :default => 'config.rb'
    )
  end

end