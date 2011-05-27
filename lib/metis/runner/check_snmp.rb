require 'net_snmp'

class Metis::Runner::CheckPort < Metis::Runner
  def execute
    timeout = @params[:timeout] || 3
    version = @params[:version] || :SNMPv1
    community @params[:community] || 'public'

    manager = NetSNMP::Manager.new(:host => host[:ip_address], :version => version, :community => community, :timeout => timeout)
    response = manager.get(@params[:oid])
    if response.error_status == NetSNMP::SUCCESS
      response.each_varbind {|vb| puts "#{vb.name}: #{vb.value}"}
    else
      puts response.error_description
    end
  end
end
