class Metis::SystemContext

  include Metis::Mixin::ConvertToClassName

  attr_reader :hosts
  attr_reader :roles
  attr_reader :checks

  def initialize
    @hosts = {}
    @roles = {}
    @checks = {}
  end

  def converge
    @hosts.values.each do |host|
      host.checks.each do |c|
        host.checks.replace(c, load_check(host, c))
      end

      host.checks << host.roles.flatten.collect do |role|
        r = @roles[role]
        next unless r
        r.checks.flatten.collect { |c| load_check(host, c) }
      end

      host.checks.flatten!.compact!
    end
  end

  def monitor
    @hosts.values.each do |host|
      host.checks.map(&:_execute)
      puts "WARNING!  HOST #{host.name} HAS ALERTS:\n#{host.alerts.join("\n")}\n\n" unless host.alerts.empty?
    end
  end

  private

  def load_check(host, params)
    check_context = @checks[params[:name]] || {}

    check_class = find_class_or_symbol(params[:type] || check_context[:type])
    #raise "Invalid check defined: #{params.inspect}"
    return nil unless check_class

    check_params = (check_context[:params] || {})
    if check_context[:block]
      resource = Metis::HostResource.new(host)
      resource.instance_eval(&check_context[:block])
      check_params.merge!(resource.params) if resource.params
    end
    check_params.merge!(params[:params] || {})

    check = check_class.new(params[:name], host, check_params)
    check.from_block(&check_context[:block]) if check_context[:block]
    check
  end

  def find_class_or_symbol(sym)
    return nil unless sym
    return sym if sym.is_a?(Class)

    class_name = convert_to_class_name(sym.to_s)
    Metis::Runner.const_get(class_name)
  end

end