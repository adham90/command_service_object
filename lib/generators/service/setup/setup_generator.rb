module Service
  module Generators
    class SetupGenerator < Rails::Generators::Base
      def setup
        return if File.exist?("app/services/#{service_name}")

        empty_directory("app/services/#{service_name}")
        empty_directory("app/services/#{service_name}/listeners")
        empty_directory("app/services/#{service_name}/jobs")
        empty_directory("app/services/#{service_name}/externals")
        empty_directory("app/services/#{service_name}/query_objects")
        empty_directory("app/services/#{service_name}/usecases")
        empty_directory("app/services/#{service_name}/commands")
        empty_directory("app/services/#{service_name}/usecases/micros")
      end

      private

      def service_name
        "#{args.first.underscore}_service"
      end
    end
  end
end
