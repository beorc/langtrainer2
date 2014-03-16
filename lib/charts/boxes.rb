module Charts
  class Boxes < Base

    def initialize(user, period, language, course, unit)
      @language = language
      @course = course
      @unit = unit

      super(user, period)
    end

    def collect
      data = {}
      data[:labels] = (1..Rails.configuration.boxes_number).map { |num| num }
    end
  end
end


