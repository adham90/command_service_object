$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'command_service_object'

require 'minitest/autorun'
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
