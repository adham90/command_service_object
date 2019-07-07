require_relative '../setup/setup_generator.rb'

module Service
  module Generators
    class MicroGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      argument :micros, type: :array, default: [], banner: 'micros micros'

      def setup
        invoke Service::Generators::SetupGenerator, [name]
      end

      def create_micros
        micros.each do |m|
          @micro = m.classify

          path = "app/services/#{service_name}/usecases/micros/#{m.underscore}.rb"
          template 'micro.rb.erb', path
        end
      end

      private

      def service_name
        "#{name.underscore}_service"
      end
    end
  end
end
