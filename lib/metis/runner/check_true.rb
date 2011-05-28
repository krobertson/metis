class Metis::Runner::CheckTrue < Metis::Runner

  setting :block

  def execute
    response = block.call
    add_alert('Returned false') unless response
  end

end
