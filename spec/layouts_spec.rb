require 'rspec'
require_relative '../lib/carlosgoce/calendar'
require_relative '../lib/carlosgoce/layout/layouts'

describe 'Layout simple' do
  before(:each) do
    @calendar = CarlosGoce::Calendar.new
    @layout = CarlosGoce::Layout::Simple.new
    @file = 'output/simple.pdf'
    FileUtils.rm_f(@file)
  end

  # Check the generated file on spec/output
  it 'creates a pdf' do
    @calendar.generate(@layout, @file, Date.today.year)
    expect(File.exist? @file).to be(true), lambda {"File #{@file} was not created"}
  end
end