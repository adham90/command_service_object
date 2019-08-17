# frozen_string_literal: true

class ApplicationService
  class << self
    def call(cmd)
      raise Errors::InvalidCommand, cmd.class if cmd.invalid?

      usecase = usecase_for(cmd).new(cmd)
      result  = ServiceResult.new { usecase.call }

      rollback(usecase, result, cmd) if result.error.present?
      result
    rescue StandardError => e
      log_errors(e, cmd)
      ServiceResult.new { raise e }
    end

    def rollback(usecase, result, cmd)
      usecase.rollback_micros
      usecase.rollback
      log_errors(result.error, cmd)
    end

    def log_errors(err, _cmd)
      return if err.class.is_a?(CommandServiceObject::Failure)
      # Add your logging logic
      # ex:
      #   Rollbar.error(err)
    end

    private

    def usecase_for(cmd)
      cmd.class.name.gsub('Commands', 'Usecases').constantize
    end
  end
end
