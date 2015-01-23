require 'rubygems'
require 'Prawn'

module CarlosGoce
  module Layout
    class Simple
      def create (file, data, year)
        Prawn::Document.generate(file) do
          text 'Hello World'
        end
      end
    end
  end
end