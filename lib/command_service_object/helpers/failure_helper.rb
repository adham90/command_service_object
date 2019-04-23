module CommandServiceObject
  module FailureHelper
    def fail!(message: '', extra_data: {})
      raise Failure, message: message, extra_data: extra_data
    end
  end
end
