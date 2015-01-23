require 'rubygems'
require 'prawn'
require 'prawn/table'

module CarlosGoce
  module Layout
    class Simple
      def create (file, data, year)
        Prawn::Document.generate(file) do
          data.each do |k, month|
            days = data[k][:days]

            text data[k][:name]
            cells = (days).to_a.each_slice(7).to_a
            table cells, :cell_style => {:align => :center}
          end
        end
      end
    end
  end
end