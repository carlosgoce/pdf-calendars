require 'rubygems'
require 'bundler/setup'
require 'prawn'

output_folder = 'output'

Prawn::Document.generate("#{output_folder}/calendar.pdf") do
  text 'Hello World'
end