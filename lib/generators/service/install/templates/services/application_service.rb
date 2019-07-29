# frozen_string_literal: true

class ApplicationService
  class << self
    def call(cmd)
      raise Errors::InvalidCommand, cmd.class if cmd.invalid?

      usecase = usecase_for(cmd).new(cmd)
      result  = ServiceResult.new { usecase.call }

      if result.error.present?
        usecase.rollback_micros
        usecase.rollback
      end

      result
    rescue StandardError => e
      handle_errors(e)
    end

    def handle_errors(error)
      # Add your logging logic
      # ex:
      #   Rollbar.error(failure)
      #

      raise error
    end

    private

    def usecase_for(cmd)
      cmd.class.name.gsub('Commands', 'Usecases').constantize
    end
  end
end
