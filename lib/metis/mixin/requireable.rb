class Metis
  module Mixin
    module Requireable
      attr_reader :requires

      def include_require(*libs)
        @requires ||= []
        @requires << libs
      end
    end
  end
end
