require_relative '../setup/setup_generator.rb'

module Service
  module Generators
    class EntityGenerator < Rails::Generators::NamedBase  
      source_root File.expand_path('templates', __dir__)

      argument :entities, type: :array, default: [], banner: 'entity entity'

      def setup
        invoke Service::Generators::SetupGenerator, [name]
      end

      def create_micros
        entities.each do |e|
          @entity = e.classify

          path = "app/services/#{service_name}/entities/#{e.underscore}.rb"
          template 'entity.rb.erb', path
        end
      end

      private

      def service_name
        "#{name.underscore}_service"
      end
    end
  end
end
