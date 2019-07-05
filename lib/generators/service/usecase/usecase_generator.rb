require_relative '../setup/setup_generator.rb'

module Service
  module Generators
    class UsecaseGenerator < Rails::Generators::NamedBase
      # check_class_collision

      source_root File.expand_path('templates', __dir__)

      argument :usecases, type: :array, default: [], banner: 'usecase usecase'

      def call
        invoke Service::Generators::SetupGenerator, [name]

        usecases.each do |u|
          @usecase = u.classify
          path = "app/services/#{service_name}/usecases/#{u.underscore}.rb"
          template 'usecase.rb.erb', path
        end
      end

      private

      def service_name
        "#{name.underscore}_service"
      end
    end
  end
end
