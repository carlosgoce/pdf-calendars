require 'rubygems'
require 'bundler/setup'
require 'prawn'
require 'prawn/table'
require 'active_support/core_ext/time'
require 'active_support/core_ext/date'

locales_folder = 'config/locales'
output_folder = 'output'

# Para obtener el primer día de la semana
d = Date.today
puts d.beginning_of_week

I18n.load_path = Dir["#{locales_folder}/*.yml"]
I18n.backend.load_translations
I18n.locale = 'es' || I18n.default_locale

Prawn::Document.generate("#{output_folder}/calendar.pdf") do
  (1..12).each do |month|
    text I18n.t('date.month_names')[month]
    data = (1..Time.days_in_month(month)).to_a.each_slice(7).to_a
    table data, :cell_style => {:align => :center}
  end
end

# `open #{output_folder}/calendar.pdf`