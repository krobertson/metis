class Metis::Runner::Check < Metis::Runner

  def execute
    response = @params[:execute].call
    add_alert('returned false') unless response
  end

end
