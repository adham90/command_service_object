module Service
  module Generators
    class SetupGenerator < Rails::Generators::Base
      def setup
        return if File.exist?("app/services/#{service_name}")

        empty_directory("app/services/#{service_name}")
        empty_directory("app/services/#{service_name}/usecases")
        empty_directory("app/services/#{service_name}/commands")
        empty_directory("app/services/#{service_name}/commands/validators")
        empty_directory("app/services/#{service_name}/errors")
      end

      private

      def service_name
        "#{args.first.underscore}_service"
      end
    end
  end
end
