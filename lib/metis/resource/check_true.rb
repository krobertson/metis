class Metis::Resource::CheckTrue < Metis::Resource
  provider_base Metis::Provider::CheckTrue

  def execute(&block)
    set_or_return(:execute, block, :kind_of => [Proc])
  end
end
