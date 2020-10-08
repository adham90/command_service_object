require_relative '../setup/setup_generator.rb'
require_relative '../helper'

module Service
  module Generators
    class QueryGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      argument :queries, type: :array, default: [], banner: 'query query'

      def setup
        invoke Service::Generators::SetupGenerator, [name]
      end

      def create_queries
        queries.each do |m|
          @query = m.classify

          path = "#{service_path}/queries/#{m.underscore}.rb"
          template 'query.rb.erb', path
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
