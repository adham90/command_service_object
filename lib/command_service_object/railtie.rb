module CommandServiceObject
  class Railtie < Rails::Railtie
    initializer 'configure_rails_initialization' do |_app|
      ActiveSupport.on_load :action_controller do
        CommandServiceObject::Railtie.setup_action_controller
      end
    end

    def self.setup_action_controller
      ActionController::Base.send :include, ControllerHelper
    end
  end
end
