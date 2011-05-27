class Metis
  module Mixin
    module ConvertToClassName
      def convert_to_class_name(str)
        rname = nil
        regexp = %r{^(.+?)(_(.+))?$}

        mn = str.match(regexp)
        if mn
          rname = mn[1].capitalize

          while mn && mn[3]
            mn = mn[3].match(regexp)          
            rname << mn[1].capitalize if mn
          end
        end

        rname
      end
    end
  end
end
