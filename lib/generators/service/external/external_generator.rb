require_relative '../setup/setup_generator.rb'

module Service
  module Generators
    class ExternalGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      argument :externals, type: :array, default: [], banner: 'external external'

      def setup
        invoke Service::Generators::SetupGenerator, [name]
      end

      def create_micros
        externals.each do |m|
          @external = m.classify

          path = "app/services/#{service_name}/externals/#{m.underscore}.rb"
          template 'external.rb.erb', path
        end
      end

      private

      def service_name
        "#{name.underscore}_service"
      end
    end
  end
end
