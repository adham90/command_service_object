# require 'rails/generators'
# require 'rails/generators/base'

module CommandServiceObject
  class InstallGenerator < ::Rails::Generators::Base

    source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

    def initializer
      puts 'creating initializer...'
      if configured?
        abort "It looks like you've already configured #{config_file_path}."
      end

      template 'initializer.rb', config_file_path
    end

    private

    def configured?
      File.exist?(config_file_path)
    end

    def config_file_path
      'config/initializers/command_service_object.rb'
    end
  end
end
