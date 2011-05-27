class Metis
  module Mixin
    module Roleable

      attr_accessor :roles

      def include_role(name)
        @roles ||= []
        @roles << name unless @roles.include?(name)
      end

    end
  end
end
