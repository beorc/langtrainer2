module Charts
  class Base
    attr_reader :data

    def initialize
      @data = {}

      collect
    end
  end
end
