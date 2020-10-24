require_relative '../setup/setup_generator.rb'
require_relative '../helper'

module Service
  module Generators
    class ListenerGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      argument :listeners, type: :array, default: [], banner: 'Listener Listener'

      def create_micros
        listeners.each do |m|
          @listener = m.classify

          path = "#{service_path}/listeners/#{m.underscore}.rb"
          template 'listener.rb.erb', path
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
