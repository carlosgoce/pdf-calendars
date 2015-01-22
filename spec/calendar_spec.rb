require 'rspec'
require 'rspec/expectations'
require_relative '../lib/carlosgoce/calendar'

I18n.load_path = Dir['config/locales/*.yml']
I18n.backend.load_translations

describe 'Calendar' do
  before(:each) do
    @calendar = CarlosGoce::Calendar.new
  end

  it 'should be initialized with the current year' do
    expect(@calendar.year).to eq(Date.today.year)
  end

  describe 'Return months and days of given year' do
    it 'should have all months of the year' do
      expect(@calendar.to_h.count).to eq(12)
    end

    it 'localize month names' do
      expect(@calendar.to_h.keys.first.to_s).to eq('january')
      I18n.locale = 'es'
      expect(@calendar.to_h.keys.first.to_s).to eq('enero')
    end
  end
end