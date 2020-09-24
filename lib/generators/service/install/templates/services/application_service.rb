# frozen_string_literal: true

class ApplicationService
  class << self
    attr_reader :cmd, :usecase, :bm, :result

    def call(cmd)
      @cmd = cmd
      @bm = Benchmark.measure do
        raise Errors::InvalidCommand, cmd.class if cmd.invalid?

        @usecase = usecase_class.new(cmd)
        raise Errors::NotAuthorizedError, cmd.class unless usecase.allowed?

        @result = ServiceResult.new { usecase.call }

        rollback if result.error.present?
      end

      result
    rescue StandardError => e
      log_errors(e)
      ServiceResult.new { raise e }
    ensure
      log_command
    end

    def rollback
      usecase.rollback_micros
      usecase.rollback
      log_errors(result.error)
    end

    private

    def log_errors(err)
      return if err.class.is_a?(CommandServiceObject::Failure)
      # Add your logging logic
      # ex:
      #   Rollbar.error(err)
    end

    def log_command
      service_logger = ActiveSupport::TaggedLogging.new(ActiveSupport::Logger.new(Rails.root.join('log', 'services.log').to_s))
      status = result.ok? ? 'success' : 'faild'

      service_logger.tagged(service_name, usecase_name, status) do
        service_logger.info(
          {
            cmd: cmd.as_json,
            result: result.value!.as_json,
            benchmark: bm.as_json
          }.as_json
        )
      end
    end

    def usecase_class
      cmd.class.name.gsub('Commands', 'Usecases').constantize
    end

    def service_name
      cmd.class.name.split('::').first
    end

    def usecase_name
      cmd.class.name.split('::').last
    end
  end
end
