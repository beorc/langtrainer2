module Charts
  class Base
    attr_reader :data

    def initialize(user, period)
      @user = user
      @period = period
      @data = {}

      collect
    end
  end
end
