require 'rails/generators/testing/behaviour'
require_relative '../../lib/generators/service/service_generator'

class ServiceGeneratorTest < Rails::Generators::TestCase
  tests ServiceGenerator
  destination File.expand_path('../tmp', __dir__)
  setup :prepare_destination
  teardown :prepare_destination

  test 'user_service files creation' do
    run_generator %w[user login]
    assert_file 'app/services/application_service.rb'
    assert_file 'app/services/service_base.rb'
    assert_file 'app/services/service_result.rb'
    assert_file 'app/services/user_service/usecases/login.rb'
    assert_file 'app/services/user_service/commands/login.rb'
  end
end
