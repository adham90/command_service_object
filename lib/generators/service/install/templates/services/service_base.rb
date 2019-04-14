# frozen_string_literal: true

class ServiceBase
  attr_reader :cmd

  def initialize(command)
    @cmd = command
  end

  def self.call(command)
    raise Errors::InvalidCommand, command.class if command.invalid?

    obj = new(command)
    obj.call
  rescue StandardError => e
    error(e)
    obj.send(:rollback)
    raise e
  end

  private

  def self.error(err)
    # don't log custom errors if you want :D
    return if err.class.name.start_with?(self.class.name.split('::').first)

    #
    # Add your logging logic
    # ex:
    #   Rollbar.error(err)
    #
  end

  def rollback
    raise NotImplementedError
  end
end
