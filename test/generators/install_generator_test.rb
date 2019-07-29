require 'rails/generators/testing/behaviour'
require 'test_helper'
require 'byebug'
require_relative '../../lib/generators/service/install/install_generator'

class InstallGeneratorTest < Rails::Generators::TestCase
  include GeneratorTestHelpers
  tests Service::Generators::InstallGenerator

  destination File.expand_path('../tmp', __dir__)

  create_generator_sample_app

  Minitest.after_run do
    remove_generator_sample_app
  end

  setup do
    run_generator
  end

  test 'user_service files creation' do
    assert_file 'app/services/application_service.rb'
    assert_file 'app/services/case_base.rb'
    assert_file 'app/services/service_result.rb'
  end
end
