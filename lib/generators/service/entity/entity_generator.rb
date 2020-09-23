require_relative '../setup/setup_generator.rb'

module Service
  module Generators
    class EntityGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      argument :entities, type: :array, default: [], banner: 'entities entities'

      def setup
        invoke Service::Generators::SetupGenerator, [name]
      end

      def create_micros
        entities.each do |m|
          @entity = m.classify

          path = "app/services/#{service_name}/entities/#{m.underscore}.rb"
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
