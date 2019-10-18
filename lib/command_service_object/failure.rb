module CommandServiceObject
  class Failure < StandardError
    attr_reader :command

    def initialize(message: nil, command: {})
      @command = command
      super(message)
    end
  end
end
