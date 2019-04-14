require 'rails/generators'

module Service
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      def create_initializer_file
        template 'initializer.rb', config_file_path
      end

      def create_services_dir
        directory 'services', 'app/services'
      end

      private

      def config_file_path
        'config/initializers/command_service_object.rb'
      end
    end
  end
end
