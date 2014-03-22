module Charts
  class Boxes < Base

    def initialize(boxes)
      @boxes = boxes
      super()
    end

    def collect
      @data = {}
      @data[:labels] = (1..Rails.configuration.boxes_number).map { |num| num }
      @data[:datasets] = []

      counts = (1..Rails.configuration.boxes_number).map do |num|
        @boxes.where(number: num).count
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

