class Metis::DslResource
  def initialize(parent)
    @parent = parent

    parent.class.settings.keys.each do |key|
      self.class.class_eval do
        define_method "#{key}" do |*value,&block|
          parent.send(:"#{key}=", block ? block : value.first)
        end
      end
    end if parent.class.settings
  end
end
