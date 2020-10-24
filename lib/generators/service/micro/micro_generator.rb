require_relative '../setup/setup_generator.rb'
require_relative '../helper'

module Service
  module Generators
    class MicroGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      argument :micros, type: :array, default: [], banner: 'micros micros'

      def create_micros
        micros.each do |m|
          @micro = m.classify

          path = "#{service_path}/usecases/micros/#{m.underscore}.rb"
          template 'micro.rb.erb', path
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
