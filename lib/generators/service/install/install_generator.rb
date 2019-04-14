require 'rails/generators'

module Service
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def create_base_dir
        directory 'base', 'app/services'
      end
    end
  end
end
