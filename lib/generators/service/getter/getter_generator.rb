require_relative '../setup/setup_generator.rb'

module Service
  module Generators
    class GetterGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      argument :getters, type: :array, default: [], banner: 'getter getter'

      def setup
        invoke Service::Generators::SetupGenerator, [name]
      end

      def create_getters
        getters.each do |g|
          @getter = g.classify

          path = "app/services/#{service_name}/usecases/getters/#{g.underscore}.rb"
          template 'getter.rb.erb', path
        end
      end

      private

      def service_name
        "#{name.underscore}_service"
      end
    end
  end
end
