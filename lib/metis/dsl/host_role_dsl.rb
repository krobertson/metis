class Metis
  module Dsl
    class HostRoleDsl

      attr_reader :context, :checks, :roles

      def initialize(context)
        @context = context
        @checks = {}
        @roles = []
      end

      def host
        @context.host
      end

      def include_role(name)
        @roles << name unless @roles.include?(name)
      end

      def include_check(name, *args)
        check_params = args.pop || {}
        @checks << { :name => name, :type => args.first, :params => check_params }
      end

    end
  end
end
