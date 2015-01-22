require 'rspec'
require_relative '../lib/carlosgoce/calendar'

describe 'Calendar' do
  before(:each) do
    @calendar = CarlosGoce::Calendar.new
  end

  describe 'Return months and days of given year' do
    it 'localize month names' do
      expect(@calendar.to_h.keys.first.to_s).to eq('enero')
    end
  end
end