module Charts
  class Boxes < Base

    def collect
      boxes = @snapshots.boxes

      @data = {}
      @data[:columns] = []
      @data[:rows] = []
      @data[:options] = {}

      @data[:options][:title] = I18n.t('charts.boxes.title')
      @data[:options][:width] = 400
      @data[:options][:height] = 300

      @data[:columns] << { type: 'string', name: 'Tapping' }
      @data[:columns] << { type: 'number', name: 'Slices' }

      counts = (0..Rails.configuration.boxes_number-1).map do |num|
        @data[:rows] << [num.to_s, boxes.for_number(num).first.steps.count]
      end

      @data
    end
  end
end

