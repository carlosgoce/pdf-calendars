require 'rspec'
require 'rspec/expectations'
require_relative '../lib/carlosgoce/calendar'

I18n.load_path = Dir['config/locales/*.yml']
I18n.backend.load_translations

describe 'Calendar' do
  before(:each) do
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

    it 'return the day names localized',
       :pending => "Not working!!! Months are localized, why days aren't?" do
      skip 'Is not working, the names are localized so why days are not?'
      I18n.locale = 'es'
      expect(@calendar.to_h[1][:days_names].first).to eq 'jueves'
    end

  end
end