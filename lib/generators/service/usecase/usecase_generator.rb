require_relative '../setup/setup_generator.rb'

module Service
  module Generators
    class UsecaseGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      argument :usecases, type: :array, default: [], banner: 'usecase usecase'

      def call
        invoke Service::Generators::SetupGenerator, [name]

        usecases.each do |u|
          @usecase = u.classify
          create_main(u)
          create_test(u)
        end
      end

      private

      def create_main(m)
        path = "app/services/#{service_name}/usecases/#{m.underscore}.rb"
        template 'usecase.rb.erb', path unless options.skip_command?
      end

      def create_test(m)
        path = "spec/services/#{service_name}/usecases/#{m.underscore}_spec.rb"
        template 'usecase_spec.rb.erb', path
      end

      def service_name
        "#{name.underscore}_service"
      end
    end
  end
end
