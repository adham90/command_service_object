require_relative '../setup/setup_generator.rb'
require_relative '../helper'

module Service
  module Generators
    class CommandGenerator < Rails::Generators::NamedBase
      include CommandServiceObject::ModelHelper

      source_root File.expand_path('templates', __dir__)

      argument :commands, type: :array, default: [], banner: 'command command'

      def call
        invoke Service::Generators::SetupGenerator, [name]
        @model_attributes = model_attributes

        commands.each do |c|
          @command = c.classify
          create_main(c)
          create_test(c)
        end
      end

      private

      def create_main(m)
        path = "#{service_path}/commands/#{m.underscore}.rb"
        template 'command.rb.erb', path unless options.skip_command?
      end

      def create_test(m)
        path = "#{spec_path}/commands/#{m.underscore}_spec.rb"
        template 'command_spec.rb.erb', path
      end

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
