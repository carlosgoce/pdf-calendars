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

            # todo: Need improvement. Not too performant...
            # todo: Maby it should be moved to it's own class too to keep things simple
            m[:days_names] = Array.new.tap {|a|
              m[:days].each do |d|
                t = Time.new @year, month, d
                a << I18n.t('date.day_names')[t.wday].downcase
              end
            }
          }
        end
      }
    end
  end
end
