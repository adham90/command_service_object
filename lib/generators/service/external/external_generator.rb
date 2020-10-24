require_relative '../setup/setup_generator.rb'
require_relative '../helper'

module Service
  module Generators
    class ExternalGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      argument :externals, type: :array, default: [], banner: 'external external'

      def create_externals
        externals.each do |m|
          @external = m.classify
          create_main(m)
          create_test(m)
        end
      end

      private

      def create_main(m)
        path = "#{service_path}/externals/#{m.underscore}.rb"
        template 'external.rb.erb', path
      end

      def create_test(m)
        path = "#{spec_path}/externals/#{m.underscore}_spec.rb"
        template 'external_spec.rb.erb', path
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
