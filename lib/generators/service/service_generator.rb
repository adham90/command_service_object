# frozen_string_literal: true

require 'rubygems'
require_relative './setup/setup_generator.rb'
require_relative './usecase/usecase_generator.rb'
require_relative './command/command_generator.rb'
require_relative './test/test_generator.rb'
require 'rails/generators'
require 'rails/generators/model_helpers'

module Service
  module Generators
    class ServiceGenerator < Rails::Generators::NamedBase
      argument :usecases, type: :array, default: [], banner: 'usecase usecase'

      # Skiping options
      class_option :skip_usecase, type: :boolean, default: false, aliases: '-U'
      class_option :skip_command, type: :boolean, default: false, aliases: '-C'
      class_option :skip_test,    type: :boolean, default: false, aliases: '-T'

      def install_if_not
        return if File.exist?('app/services')

        generate 'service:install'
      end

      def setup
        invoke Service::Generators::SetupGenerator, [name]
      end

      def generate_usecases
        return if options.skip_usecase?

        invoke Service::Generators::UsecaseGenerator, [name, usecases]
      end

      def generate_commands
        return if options.skip_command?

        invoke Service::Generators::CommandGenerator, [name, usecases]
      end

      def generate_tests
        return if options.skip_test?

        invoke Service::Generators::TestGenerator, [name, usecases]
      end
    end
  end
end
