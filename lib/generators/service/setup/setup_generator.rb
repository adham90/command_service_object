module Service
  module Generators
    class SetupGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      def setup
        return if File.exist?("app/services/#{service_name}")

        empty_directory("app/services/#{service_name}")
        empty_directory("app/services/#{service_name}/listeners")
        empty_directory("app/services/#{service_name}/jobs")
        empty_directory("app/services/#{service_name}/externals")
        empty_directory("app/services/#{service_name}/queries")
        empty_directory("app/services/#{service_name}/usecases")
        empty_directory("app/services/#{service_name}/commands")
        empty_directory("app/services/#{service_name}/entities")
        empty_directory("app/services/#{service_name}/usecases/micros")

        path = "app/services/#{service_name}/doc.md"
        template 'doc.md.erb', path unless File.exist?(path)
      end

      private

      def service_name
        "#{args.first.underscore}_service"
      end
    end
  end
end
