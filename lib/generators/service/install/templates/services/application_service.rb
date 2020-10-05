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

      log_command
      result
    rescue StandardError => e
      ServiceResult.new { raise e }      
    end

    def rollback
      usecase.rollback_micros
      usecase.rollback
      log_errors(result.error)
    end

    private

    def log_command
      service_logger = ActiveSupport::Logger.new(Rails.root.join('log', 'services.log').to_s)
      service_logger.formatter = proc do |severity, datetime, progname, msg|
        "[#{msg['usecase']}] [#{msg['status']}] [#{datetime.to_s(:db)} ##{Process.pid}] -- #{msg['body']}\n"
      end
      log_body = result.ok? ? success_log : failure_log

      service_logger.info(log_body)
    end

    def success_log
      {
        usecase: "#{service_name}::#{usecase_name}",
        status: 'success',
        body: {
            cmd: cmd.as_json,
            result: result.value!.as_json,
            benchmark: bm.as_json
          }
      }.as_json
    end

    def failure_log
      {
        usecase: "#{service_name}::#{usecase_name}",
        status: 'faild',
        body: {
          cmd: cmd.as_json,
          error: result.error.to_s,
          benchmark: bm.as_json
        }
      }.as_json
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
