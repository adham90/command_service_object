# frozen_string_literal: true

require 'rails/generators/model_helpers'

class ServiceGenerator < Rails::Generators::NamedBase
  include Rails::Generators::ModelHelpers

  source_root File.expand_path('templates', __dir__)

  argument :usecases, type: :array, default: [], banner: 'usecase usecase'
  class_option :skip_command, type: :boolean, default: false, aliases: '-C',
                              desc: 'skip command file generation'
  class_option :skip_error, type: :boolean, default: false, aliases: '-E',
                            desc: 'skip error file generation'

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

  def create_usecases
    usecases.each do |usecase|
      @usecase = usecase
      u_path = "app/services/#{service_name}/usecases/#{usecase.underscore}.rb"
      c_path = "app/services/#{service_name}/commands/#{usecase.underscore}.rb"
      e_path = "app/services/#{service_name}/errors/#{usecase.underscore}.rb"

      template 'usecase.rb.erb', u_path
      template 'command.rb.erb', c_path unless options.skip_command?
      template 'error.rb.erb',   e_path unless options.skip_error?
    end
  end

  private

  def service_name
    "#{name.underscore}_service"
  end
end
