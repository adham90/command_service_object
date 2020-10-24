require_relative '../setup/setup_generator.rb'
require_relative '../helper'

module Service
  module Generators
    class UsecaseGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      argument :usecases, type: :array, default: [], banner: 'usecase usecase'

      def call
        usecases.each do |u|
          @usecase = u.classify
          create_main(u)
          create_test(u)
        end
      end

      private

      def create_main(m)
        path = "#{service_path}/usecases/#{m.underscore}.rb"
        template 'usecase.rb.erb', path
      end

      def create_test(m)
        path = "#{spec_path}/usecases/#{m.underscore}_spec.rb"
        template 'usecase_spec.rb.erb', path
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
