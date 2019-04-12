require "command_service_object/version"
require "command_service_object/helpers/service_controller_helper"
require "command_service_object/helpers/service_model_helper"

if defined?(Rails) && Rails::VERSION::STRING >= "3.0"
  require "command_service_object/railtie"
end

module CommandServiceObject
  class Error < StandardError; end
  # Your code goes here...
end
