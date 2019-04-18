# frozen_string_literal: true

class UsecaseBase
  include CommandServiceObject::Hooks

  attr_reader :cmd

  def initialize(cmd)
    raise Errors::InvalidCommand, cmd.class if cmd.invalid?

    @cmd = cmd
  end

  def rollback; end

  private

  def fail!(message: nil, extra_data: {})
    raise CommandServiceObject::Failure, command: cmd,
                                         message: message,
                                         extra_data: extra_data
  end
end
