require_relative '../setup/setup_generator.rb'

module Service
  module Generators
    class TestGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)
      argument :tests, type: :array, default: [], banner: 'usecase usecase'

      def generate_test
        return if options.skip_test?

        if defined?(Minitest)
          minitest_test
        elsif defined?(RSpec)
          rspec_test
        end
      end

      private

      def minitest_test
        dir = create_test_dir('test')

        tests.each do |t|
          @test = t.classify
          path  = "#{dir}/usecases/#{t.underscore}_test.rb"
          template 'minitest/usecase.rb.erb', path
        end
      end

      def rspec_test
        dir = create_test_dir('spec')
        create_usecase_test(dir)
        create_command_test(dir)
      end

      def create_usecase_test(dir)
        tests.each do |t|
          @test = t.classify
          path  = "#{dir}/usecases/#{t.underscore}_spec.rb"
          template 'rspec/usecase.rb.erb', path
        end
      end

      def create_command_test(dir)
        tests.each do |t|
          @test = t.classify
          path  = "#{dir}/commands/#{t.underscore}_spec.rb"
          template 'rspec/command.rb.erb', path
        end
      end

      def create_test_dir(path)
        test_path    = "#{path}/services"
        service_test = "#{test_path}/#{service_name}"
        usecases_path = "#{test_path}/#{service_name}/usecases"
        commands_path = "#{test_path}/#{service_name}/commands"

        empty_directory(test_path)    unless File.exist?(test_path)
        empty_directory(service_test) unless File.exist?(service_test)
        empty_directory(usecases_path) unless File.exist?(usecases_path)
        empty_directory(commands_path) unless File.exist?(commands_path)

        service_test
      end

      def service_name
        "#{name.underscore}_service"
      end
    end
  end
end
