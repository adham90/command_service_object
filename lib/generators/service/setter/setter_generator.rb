require_relative '../setup/setup_generator.rb'

module Service
  module Generators
    class SetterGenerator < Rails::Generators::NamedBase
      # check_class_collision

      source_root File.expand_path('templates', __dir__)

      argument :setters, type: :array, default: [], banner: 'setters setters'

      def setup
        invoke Service::Generators::SetupGenerator, [name]
      end

      def create_setters
        setters.each do |s|
          @setter = s.classify

          path = "app/services/#{service_name}/usecases/setters/#{s.underscore}.rb"
          template 'setter.rb.erb', path
        end
      end

      private

      def service_name
        "#{name.underscore}_service"
      end
    end
  end
end
