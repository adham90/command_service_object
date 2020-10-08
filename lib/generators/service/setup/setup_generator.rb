require_relative '../helper'

module Service
  module Generators
    class SetupGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      DIRS = %w(listeners jobs externals queries usecases commands entities usecases/micros)

      def setup
        DIRS.each do |dir|
          empty_directory("#{service_path}/#{dir}")
        end

        path = "#{service_path}/doc.md"
        template 'doc.md.erb', path unless File.exist?(path)
      end

      private

      def service_name
        Service::Helper.service_name(args.first)
      end

      def service_path
        Service::Helper.service_path(args.first)
      end

      def spec_path
        Service::Helper.spec_path(args.first)
      end
    end
  end
end
