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
        h[:months] = Hash.new.tap do |h|
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

            h[month][:formatted_days] = Array.new.tap {|a|
              days_before_week_start = Date.new(@year, 1, h[1][:days].first).wday
              empty_days = [''] * (days_before_week_start - 1)

              a << (empty_days + h[1][:days])
            }
          end
        end
      }
    end

    def generate(layout, file, year)
      layout.create file, to_h, year
    end
  end
end
