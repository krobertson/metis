class Metis
  module Mixin
    module ClassSettings
      attr_reader :settings

      def setting(name, params={})
        @settings ||= {}
        params[:type] = [params[:type]].compact unless params[:type].is_a?(Array)
        @settings[name] = params
      end
    end

    module InstanceSettings
      def implement_settings
        return unless self.class.settings
        self.class.settings.each_pair do |key,value|
          iv_key = "@#{key}".to_sym
          self.instance_variable_set(iv_key, value[:default])

          self.class.class_eval do
            attr_accessor key
            unless value[:type].empty?
              define_method "#{key}=" do |v|
                raise "#{key} must be of type: #{value[:type].map(&:to_s).join(', ')}" unless value[:type].include?(v.class)
                self.instance_variable_set(iv_key, v)
              end
            end                
          end
        end
      end
      
    end
  end
end