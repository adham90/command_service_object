# frozen_string_literal: true

require 'rubygems'
require_relative './setup/setup_generator.rb'
require_relative './usecase/usecase_generator.rb'
require_relative './command/command_generator.rb'
require 'rails/generators'
require 'rails/generators/model_helpers'
require_relative './helper.rb'

module Service
  module Generators
    class ServiceGenerator < Rails::Generators::NamedBase
      argument :usecases, type: :array, default: [], banner: 'usecase usecase'

      def install_if_not
        return if File.exist?('app/services')

        generate 'service:install'
      end

      def setup
        invoke Service::Generators::SetupGenerator, [name]
      end

      def generate_usecases
        invoke Service::Generators::UsecaseGenerator, [name, usecases]
      end

      def generate_commands
        invoke Service::Generators::CommandGenerator, [name, usecases]
      end

      private

      def service_name
        Service::Helper.service_name(name)
      end

      def service_path
        Service::Helper.service_path(name)
      end

      def spec_path
        Service::Helper.spec_path(name)
      end
    end
  end
end
