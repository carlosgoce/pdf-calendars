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
      Hash.new.tap {|h|
        (1..12).each do |month|
          h[month] = Hash.new.tap {|m|
            m[:days] = (1..Time.days_in_month(month, @year)).to_a
            m[:name] = I18n.t('date.month_names')[month].downcase
          }
        end
      }
    end
  end
end
