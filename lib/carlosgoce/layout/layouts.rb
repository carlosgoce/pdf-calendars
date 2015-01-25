require 'rubygems'
require 'prawn'
require 'prawn/table'

module CarlosGoce
  module Layout
    class Simple
      def create (file, data, year)
        tables = []
        Prawn::Document.generate(file) do
          font_size = 16

          data[:months].each do |k, month|
            days = month[:formatted_days]
            cells = days.to_a.each_slice(7).to_a
            cells.unshift %w(L M X J V S D)
            cells.unshift [{content: "<color rgb='FF0000'><strong>#{month[:name]}</strong></color>", colspan: 7,
                           inline_format: true}]

            tables << make_table(cells,
                                 cell_style:
                                     {
                                         width: 15, height: 12, align: :center, size: 7, border_width: 0,
                                         padding: 0, valign: :center
                                     })
          end

          table(
              tables.each_slice(3).to_a, cell_style: {align: :center, padding: [5, 5, 5, 5], border_width: 0,
                                                      valign: :center}
          )
        end
      end
    end
  end
end