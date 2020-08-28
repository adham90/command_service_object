require_relative '../setup/setup_generator.rb'

module Service
  module Generators
    class RepositoryGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      argument :repos, type: :array, default: [], banner: 'repo repo'

      def setup
        invoke Service::Generators::SetupGenerator, [name]
      end

      def create_repos
        repos.each do |m|
          @repo_name = m.classify

          path = "app/services/#{service_name}/repositories/#{@repo_name.underscore}.rb"
          template 'repository.rb.erb', path
        end
      end

      private

      def service_name
        "#{name.underscore}_service"
      end
    end
  end
end
