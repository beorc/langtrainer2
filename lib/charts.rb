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
end
