require_relative '../setup/setup_generator.rb'

module Service
  module Generators
    class ExternalGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      argument :externals, type: :array, default: [], banner: 'external external'

      def create_externals
        invoke Service::Generators::SetupGenerator, [name]

        externals.each do |m|
          @external = m.classify
          create_main(m)
          create_test(m)
        end
      end

      private

      def create_main(m)
        path = "app/services/#{service_name}/externals/#{m.underscore}.rb"
        template 'external.rb.erb', path
      end

      def create_test(m)
        path = "spec/services/#{service_name}/externals/#{m.underscore}_spec.rb"
        template 'external_spec.rb.erb', path
      end

      def service_name
        "#{name.underscore}_service"
      end
    end
  end
end
