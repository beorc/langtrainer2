module Charts
  class Boxes < Base

    def collect
      boxes = @snapshots.boxes

      @data = {}
      @data[:columns] = []
      @data[:rows] = []
      @data[:options] = {}

      @data[:columns] << { type: 'string', name: I18n.t('charts.boxes.columns.name') }
      @data[:columns] << { type: 'number', name: I18n.t('charts.boxes.columns.count') }

      counts = (0..Rails.configuration.boxes_number-1).map do |num|
        @data[:rows] << [num.to_s, boxes.for_number(num).first.steps.count]
      end

      @data
    end
  end
end

