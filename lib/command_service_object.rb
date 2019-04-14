require "command_service_object/version"
require "command_service_object/configuration"
require "command_service_object/helpers/service_controller_helper"
require "command_service_object/helpers/service_model_helper"

if defined?(Rails) && Rails::VERSION::STRING >= "3.0"
  require "command_service_object/railtie"
end

module CommandServiceObject
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
