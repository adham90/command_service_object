# frozen_string_literal: true

class UsecaseBase
  attr_reader :cmd

  def initialize(cmd)
    @cmd = cmd
  end

  class << self
    def call(cmd)
      raise Errors::InvalidCommand, cmd.class if cmd.invalid?

      obj = new(cmd)
      obj.call
    rescue StandardError => e
      handle_failure(e)
      obj.send(:rollback)
      raise e
    end

    def handle_failure(failure)
      # don't log custom failures if you want :D
      return if failure.is_a?(CommandServiceObject::Failure)

      #
      # Add your logging logic
      # ex:
      #   Rollbar.error(err)
      #
    end
  end

  private

  def fail!(message: nil, extra_data: {})
    raise CommandServiceObject::Failure, command: cmd,
                                         message: message,
                                         extra_data: extra_data
  end

  def rollback; end
end
