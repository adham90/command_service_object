module CommandServiceObject
  class Failure < StandardError
    attr_reader :extra_data

    def initialize(message: nil, extra_data: {})
      @extra_data = extra_data
      super(message)
    end
  end
end
