class Metis::Configuration
  include Metis::Mixin::FromFile
  include Metis::Mixin::ParamsValidate

  attr_reader :params, :blocks

  def initialize
    @params = {}
    @blocks = Hash.new { |h,k| h[k] = [] }
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

  def configure(check_name, &block)
    @blocks[check_name] << block
  end

end
