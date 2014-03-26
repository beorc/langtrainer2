module Charts
  class Hints < Base

    def collect
      @data = {}
      @data[:columns] = []
      @data[:rows] = []
      @data[:options] = {}

      @data[:columns] << { type: 'string', name: I18n.t('charts.hints.columns.date') }
      @data[:columns] << { type: 'number', name: I18n.t('charts.hints.columns.passed') }
      @data[:columns] << { type: 'number', name: I18n.t('charts.hints.columns.steps_helped') }
      @data[:columns] << { type: 'number', name: I18n.t('charts.hints.columns.words_helped') }

      dates = ::DatesRange.new(@period.start_date, Date.today).every(days: 1)

      dates.map do |d|
        snapshot = @snapshots.for_date(d).first

        passed = snapshot ? snapshot.send(:steps_passed) : 0
        steps = snapshot ? snapshot.send(:steps_helped) : 0
        words = snapshot ? snapshot.send(:words_helped) : 0

        @data[:rows] << [d.strftime("%b %d"), passed, steps, words]
      end

      @data
    end
  end
end

