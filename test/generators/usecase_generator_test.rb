require 'rails/generators/testing/behaviour'
require 'test_helper'
require 'byebug'
require_relative '../../lib/generators/service/usecase/usecase_generator'

class UsecaseGeneratorTest < Rails::Generators::TestCase
  include GeneratorTestHelpers
  tests Service::Generators::UsecaseGenerator

  destination File.expand_path('../tmp', __dir__)

  create_generator_sample_app

  Minitest.after_run do
    remove_generator_sample_app
  end

  setup do
    run_generator %w[auth login]
  end

  test 'user_service files creation' do
    assert_file 'app/services/auth_service/usecases/login.rb'
  end
end
