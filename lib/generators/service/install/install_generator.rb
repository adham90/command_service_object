require 'rails/generators'

module Service
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('.', __dir__)

      def create_base_dir
        directory 'templates', 'app/services'
      end
    end
  end
end
