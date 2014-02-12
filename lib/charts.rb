module Charts
  class Base
    attr_reader :labels, :datasets

    def initialize(user, range)
      @labels = []
      @datasets = {}
      @user = user
      @range = range

      collect
    end
  end
end
