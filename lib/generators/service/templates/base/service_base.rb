# frozen_string_literal: true

class ServiceBase
  attr_reader :cmd

  def initialize(command)
    @cmd = command
  end

  def self.call(command)
    raise Errors::InvalidCommand, command.class if command.invalid?

    new(command).call
  end
end
