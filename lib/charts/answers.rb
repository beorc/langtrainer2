module Charts
  class Answers < Base

    def collect
      @data = {}
      @data[:columns] = []
      @data[:rows] = []
      @data[:options] = {}

      @data[:columns] << { type: 'string', name: I18n.t('charts.answers.columns.date') }
      @data[:columns] << { type: 'number', name: I18n.t('charts.answers.columns.passed') }
      @data[:columns] << { type: 'number', name: I18n.t('charts.answers.columns.right') }
      @data[:columns] << { type: 'number', name: I18n.t('charts.answers.columns.wrong') }

      dates = ::DatesRange.new(@period.start_date, Date.today).every(@every)

      dates.map do |d|
        snapshot = @snapshots.for_date(d).first

        passed = snapshot ? snapshot.send(:steps_passed) : 0
        right = snapshot ? snapshot.send(:right_answers) : 0
        wrong = snapshot ? snapshot.send(:wrong_answers) : 0

        @data[:rows] << [d.strftime("%b %d"), passed, right, wrong]
      end

      @data
    end
  end
end

