class Metis::Runner::Check < Metis::Runner

  setting :block

  def execute
    block.call
  end

end
