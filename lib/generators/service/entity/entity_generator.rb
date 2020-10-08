require_relative '../setup/setup_generator.rb'
require_relative '../helper'

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

          path = "#{service_path}/entities/#{m.underscore}.rb"
          template 'entity.rb.erb', path
        end
      end

      private

      def service_name
        Service::Helper.service_name(name)
      end

      def service_path
        Service::Helper.service_path(name)
      end

      def spec_path
        Service::Helper.spec_path(name)
      end
    end
  end
end
