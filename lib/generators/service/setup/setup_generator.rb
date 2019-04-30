module Service
  module Generators
    class SetupGenerator < Rails::Generators::Base
      def setup
        return if File.exist?("app/services/#{service_name}")

        empty_directory("app/services/#{service_name}")
        empty_directory("app/services/#{service_name}/usecases")
        empty_directory("app/services/#{service_name}/commands")
        empty_directory("app/services/#{service_name}/usecases/setters")
        empty_directory("app/services/#{service_name}/usecases/getters")
      end

      private

      def service_name
        "#{args.first.underscore}_service"
      end
    end
  end
end
