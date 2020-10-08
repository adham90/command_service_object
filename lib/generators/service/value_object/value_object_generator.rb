require_relative '../setup/setup_generator.rb'
require_relative '../helper'

module Service
  module Generators
    class ValueObjectGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      argument :value_objects, type: :array, default: [], banner: 'value_object value_object'

      def call
        invoke Service::Generators::SetupGenerator, [name]

        value_objects.each do |u|
          @value_object = u.classify
          create_main(u)
        end
      end

      private

      def create_main(m)
        path = "#{service_path}/value_objects/#{m.underscore}.rb"
        template 'value_object.rb.erb', path
      end

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
