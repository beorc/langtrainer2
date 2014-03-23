module Charts
  class Boxes < Base

    def collect
      boxes = @snapshots.boxes

      @data = {}
      @data[:labels] = (1..Rails.configuration.boxes_number).map { |num| num }
      @data[:datasets] = []

      counts = (0..Rails.configuration.boxes_number-1).map do |num|
        boxes.for_number(num).first.steps.count
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

