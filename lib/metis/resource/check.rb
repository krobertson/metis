class Metis::Resource::Check < Metis::Resource
  provider_base Metis::Provider::Check

  def execute(&block)
    set_or_return(:execute, block, :kind_of => [Proc])
  end
end
