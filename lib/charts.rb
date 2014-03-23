module Charts
  class Base
    attr_reader :data

    def initialize(snapshots, period)
      @snapshots = snapshots
      @period = period
      @data = {}

      collect
    end
  end

  class Answers < Base

    def collect
      dates = ::DatesRange.new(@period.start_date, Date.today).every(days: 1)

      @data = {}
      @data[:labels] = dates.map { |d| d.strftime("%b %d") }
      @data[:datasets] = []

      counts = dates.map do |d|
        snapshot = @snapshots.for_date(d).first
        snapshot ? snapshot.send(attribute_to_fetch) : 0
      end

      @data[:datasets] << {
        fillColor: "rgba(220,220,220,0.5)",
        strokeColor: "rgba(220,220,220,1)",
        data: counts
      }

      @data
    end
  end
end
