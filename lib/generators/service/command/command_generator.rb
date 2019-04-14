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
          path = "app/services/#{service_name}/commands/#{c.underscore}.rb"
          template 'command.rb.erb', path unless options.skip_command?
        end
      end

      private

      def service_name
        "#{name.underscore}_service"
      end
    end
  end
end
