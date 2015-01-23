require 'rubygems'
require 'prawn'
require 'prawn/table'

module CarlosGoce
  module Layout
    class Simple
      def create (file, data, year)
        tables = []

        Prawn::Document.generate(file) do
          data.each do |k, month|
            days = data[k][:days]

            # text data[k][:name]
            cells = (days).to_a.each_slice(7).to_a

            tables << make_table(cells, :cell_style => {:align => :center})
          end

          table(
              tables.each_slice(3).to_a,
              :cell_style => {:align => :center, :padding => [5, 5, 5, 5]}
          )
        end
      end
    end
  end
end