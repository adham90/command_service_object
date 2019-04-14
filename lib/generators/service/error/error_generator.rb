require_relative '../setup/setup_generator.rb'

module Service
  module Generators
    class ErrorGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      argument :errors, type: :array, default: [], banner: 'error error'

      def call
        invoke Service::Generators::SetupGenerator, [name]

        errors.each do |e|
          @error = e.classify
          path = "app/services/#{service_name}/errors/#{e.underscore}.rb"
          template 'error.rb.erb', path
        end
      end

      private

      def service_name
        "#{name.underscore}_service"
      end
    end
  end
end
