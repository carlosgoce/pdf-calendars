require 'rspec'
require_relative '../lib/carlosgoce/calendar'
require_relative '../lib/carlosgoce/layout/layouts'

I18n.load_path = Dir['config/locales/*.yml']
I18n.backend.load_translations

describe 'Calendar' do
  before(:each) do
    I18n.locale = 'en'
    @calendar = CarlosGoce::Calendar.new 2015
  end

  it 'should be initialized with the current year' do
    @calendar = CarlosGoce::Calendar.new
    expect(@calendar.year).to eq Date.today.year
  end

  describe 'Return a data structure with all needed data to generate a pdf' do
    it 'should have all months of the year' do
      expect(@calendar.to_h.count).to eq(12)
    end

    it 'return month names localized' do
      expect(@calendar.to_h[1][:name]).to eq 'january'
      I18n.locale = 'es'
      expect(@calendar.to_h[1][:name]).to eq 'enero'
    end

    it 'return the numbers of available days for each month' do
      expect(@calendar.to_h[1][:days]).to eq (1..31).to_a
    end

    it 'return the days as names' do
      expect(@calendar.to_h[1][:days_names].first).to eq 'thursday'
      expect(@calendar.to_h[1][:days_names].count).to eq 31
    end

    it 'return the day names localized' do
      expect(@calendar.to_h[1][:days_names].first).to eq 'thursday'
      I18n.locale = 'es'
      expect(@calendar.to_h[1][:days_names].first).to eq 'jueves'
    end

    # todo Improve spec description
    it 'return the days available formated as array leaving blank days for the starting week\'s day' do
      days_for_january_2015 = ['', '', ''] + (1..31).to_a
      expect(@calendar.to_h[:formatted_days].first).to eq days_for_january_2015
    end
  end

  describe 'Can generate a pdfs' do
    it 'should receive a layout and pass it the data to create the specified file' do
      layout = instance_double('CarlosGoce::Layout::Simple')
      file = 'destination.pdf'
      year = 2015
      expect(layout).to receive(:create).with(file, @calendar.to_h, year)

      @calendar.generate(layout, file, year)
    end
  end
end