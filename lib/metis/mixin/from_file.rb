class Metis
  module Mixin
    module FromFile

      # Loads a given ruby file, and runs instance_eval against it in the context of the current
      # object.
      #
      # Raises an IOError if the file cannot be found, or is not readable.
      def from_file(filename)
        if File.exists?(filename) && File.readable?(filename)
          self.instance_eval(IO.read(filename), filename, 1)
        else
          raise IOError, "Cannot open or read #{filename}!"
        end
      end

      # Loads a given ruby file, and runs class_eval against it in the context of the current
      # object.
      #
      # Raises an IOError if the file cannot be found, or is not readable.
      def class_from_file(filename)
        if File.exists?(filename) && File.readable?(filename)
          self.class_eval(IO.read(filename), filename, 1)
        else
          raise IOError, "Cannot open or read #{filename}!"
        end
      end

    end
  end
end
