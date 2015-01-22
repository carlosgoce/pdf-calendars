require 'rubygems'
require 'active_support/core_ext/time'
require 'active_support/core_ext/date'

module CarlosGoce
  class Calendar
    attr_reader :year

    def initialize(year=Date.today.year)
      @year = year
    end

    def to_h
      h = {}
      (1..12).each do |month|
        month_name = I18n.t('date.month_names')[month].downcase
        month_days =(1...Time.days_in_month(month, @year)).to_a.each_slice(7).to_a
        h[month_name] = month_days
      end

      h
    end
  end
end