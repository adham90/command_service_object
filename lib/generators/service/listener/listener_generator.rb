require_relative '../setup/setup_generator.rb'

module Service
  module Generators
    class ListenerGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      argument :listeners, type: :array, default: [], banner: 'Listener Listener'

      def setup
        invoke Service::Generators::SetupGenerator, [name]
      end

      def create_micros
        listeners.each do |m|
          @listener = m.classify

          path = "app/services/#{service_name}/listeners/#{m.underscore}.rb"
          template 'listener.rb.erb', path
        end
      end

      private

      def service_name
        "#{name.underscore}_service"
      end
    end
  end
end
