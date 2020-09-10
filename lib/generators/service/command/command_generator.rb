require_relative '../setup/setup_generator.rb'

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
        path = "app/services/#{service_name}/commands/#{m.underscore}.rb"
        template 'command.rb.erb', path unless options.skip_command?
      end

      def create_test(m)
        path = "spec/services/#{service_name}/commands/#{m.underscore}_spec.rb"
        template 'command_spec.rb.erb', path
      end

      def service_name
        "#{name.underscore}_service"
      end
    end
  end
end
