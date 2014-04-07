module Charts
  class Base
    attr_reader :data

    def initialize(snapshots, period, every = { days: 1 })
      @snapshots = snapshots
      @period = period
      @every = every
      @data = {}

      collect
    end
  end
end
