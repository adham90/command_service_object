CommandServiceObject.configure do |config|
  # By setting the append_controller_helper to false you will need to
  # manually include the CommandServiceObject::ServiceControllerHelper
  # module to your base controller.
  # config.append_controller_helper = true
  #
  # The default command method name is :command
  # but you can easily rename it to avoid collisions.
  # config.command_method_name = :command
  #
  # Skip the generation of commands by the rails g service command
  # config.skip_command = false
  #
  # Skip the generation of minitest/rspec by the rails g service command
  # config.skip_test = false
  #
  # Skip the generation of errors by the rails g service command
  # config.skip_error = true
end