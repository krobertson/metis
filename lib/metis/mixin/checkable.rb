class Metis
  module Mixin
    module Checkable

      attr_accessor :checks

      def include_check(name, *args)
        @checks ||= []
        check_params = args.pop || {}
        @checks << { :name => name, :type => args.first, :params => check_params }
      end

    end
  end
end
