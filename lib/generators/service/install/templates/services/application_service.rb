# frozen_string_literal: true

class ApplicationService
  class << self
    def call(cmd)
      usecase = cmd.class.name.gsub('Commands', 'Usecases').constantize.new(cmd)

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
      #   Rollbar.error(err)
      #
    end
  end
end
