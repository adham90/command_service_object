# frozen_string_literal: true

require 'rubygems'
require 'rails/generators/model_helpers'

class ServiceGenerator < Rails::Generators::NamedBase
  include Rails::Generators::ModelHelpers

  source_root File.expand_path('templates', __dir__)

  argument :usecases, type: :array, default: [], banner: 'usecase usecase'
  class_option :skip_command, type: :boolean, default: false, aliases: '-C',
                              desc: 'skip command file generation'
  class_option :skip_error, type: :boolean, default: false, aliases: '-E',
                            desc: 'skip error file generation'
  class_option :skip_test, type: :boolean, default: false, aliases: '-T',
                           desc: 'skip test file generation'

  def create_base_dir
    return if File.exist?('app/services')

    directory 'services', 'app/services'
  end

  def create_service_dir
    return if File.exist?("app/services/#{service_name}")

    empty_directory("app/services/#{service_name}")
    empty_directory("app/services/#{service_name}/usecases")
    empty_directory("app/services/#{service_name}/commands")
    empty_directory("app/services/#{service_name}/errors")
  end

  def generate_usecases
    usecases.each do |usecase|
      generate_usecase(usecase)
      generate_command(usecase)
      generate_error(usecase)
      generate_test(usecase)
    end
  end

  private

  def generate_usecase(usecase)
    @usecase = usecase.classify
    path = "app/services/#{service_name}/usecases/#{usecase.underscore}.rb"
    template 'usecase.rb.erb', path
  end

  def generate_command(command)
    @command = command.classify
    path = "app/services/#{service_name}/commands/#{command.underscore}.rb"
    template 'command.rb.erb', path unless options.skip_command?
  end

  def generate_error(error)
    @error = error.classify
    path = "app/services/#{service_name}/errors/#{error.underscore}.rb"
    template 'error.rb.erb', path unless options.skip_error?
  end

  def generate_test(test)
    return if options.skip_test?

    if defined?(Minitest)
      empty_directory('test/services')
      generate_minitest_test_files(test)
    elsif defined?(RSpec)
      empty_directory('spec/services')
      generate_rspec_test_files(test)
    end
  end

  def generate_minitest_test_files(test)
    dir = "test/services/#{service_name}"
    empty_directory(dir)

    @test = test.classify
    path  = "#{dir}/#{test.underscore}_test.rb"

    template 'minitest.rb.erb', path
  end

  def generate_rspec_test_files(test)
    dir = "spec/services/#{service_name}"
    empty_directory(dir)

    @test = test.classify
    path  = "#{dir}/#{test.underscore}_spec.rb"

    template 'rspec.rb.erb', path
  end

  def service_name
    "#{name.underscore}_service"
  end
end
