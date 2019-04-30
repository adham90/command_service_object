module CommandServiceObject
  class Configuration
    attr_accessor :append_controller_helper, :command_method_name
    attr_accessor :skip_command, :skip_test, :skip_error

    def initialize
      @append_controller_helper = true
      @command_method_name = :command
      @skip_command = false
      @skip_test = false
      @skip_error = true
    end
  end
end
