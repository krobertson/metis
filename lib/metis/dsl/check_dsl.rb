class Metis
  module Dsl
    class CheckDsl
      include Metis::Mixin::ConvertToClassName

      attr_reader :context, :checks

      def initialize(context)
        @context = context
        @checks = {}
      end

      def host
        @context.host
      end

      def method_missing(method_name, *args, &block)
        name = args.first
        @checks[name] = load_check(method_name, name, block)
      end

      private

      def load_check(type, name, block)
        check_class = Metis::Resource.const_get(convert_to_class_name(type.to_s))
        resource = check_class.new(name, context)
        resource.instance_eval(&block)
        resource
      end
    end
  end
end
