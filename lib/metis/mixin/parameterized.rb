class Metis
  module Mixin
    module Parameterized
      attr_accessor :params

      def method_missing(method_name, *args, &block)
        @params ||= {}
        @params[method_name] = block ? block : args.first
      end

    end
  end
end
