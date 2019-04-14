require 'rails/generators'

module Service
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def create_base_dir
        directory 'base', 'app/services'
      end

      def add_controller_helper_to_application_controller
        application_controller_path = 'app/controllers/application_controller.rb'

        line = File.readlines(application_controller_path).select do |li|
          li =~ /class ApplicationController </
        end.first

        inject_into_file application_controller_path, after: line do
          "  include ServiceControllerHelper\n"
        end
      end
    end
  end
end
