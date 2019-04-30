# frozen_string_literal: true

class ApplicationService
  class << self
    def call(cmd)
      raise Errors::InvalidCommand, cmd.class if cmd.invalid?

      usecase = usecase_for(cmd).new(cmd)
      usecase.call
    rescue StandardError => e
      if usecase
        usecase.rollback_setters
        usecase.rollback
      end
      handle_failure(e)
      raise e
    end

    def handle_failure(failure)
      # don't log custom failures if you want :D
      return if failure.class.is_a?(CommandServiceObject::Failure)
      #
      # Add your logging logic
      # ex:
      #   Rollbar.error(failure)
      #
    end

    private

    def usecase_for(cmd)
      cmd.class.name.gsub('Commands', 'Usecases').constantize
    end
  end
end
