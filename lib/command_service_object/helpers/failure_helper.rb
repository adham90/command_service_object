module CommandServiceObject
  module FailureHelper
    def fail!(message)
      raise Failure, message: message, command: cmd
    end
  end
end
