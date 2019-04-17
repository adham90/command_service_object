module CommandServiceObject
  class Failure < StandardError
    attr_reader :command, :extra_data

    def initialize(command: nil, message: nil, extra_data: {})
      @command    = command
      @extra_data = extra_data
      super(message)
    end
  end
end
