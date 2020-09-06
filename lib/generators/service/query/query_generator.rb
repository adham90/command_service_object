require_relative '../setup/setup_generator.rb'

module Service
  module Generators
    class QueryGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      argument :queries, type: :array, default: [], banner: 'query query'

      def setup
        invoke Service::Generators::SetupGenerator, [name]
      end

      def create_micros
        queries.each do |m|
          @query = m.classify

          path = "app/services/#{service_name}/query_objects/#{m.underscore}.rb"
          template 'query.rb.erb', path
        end
      end

      private

      def service_name
        "#{name.underscore}_service"
      end
    end
  end
end
