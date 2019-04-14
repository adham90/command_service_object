module CommandServiceObject
  class Railtie < Rails::Railtie
    initializer "configure_rails_initialization" do |app|
      ActiveSupport.on_load :action_controller do
        CommandServiceObject::Railtie.setup_action_controller
      end
    end

    def self.setup_action_controller
      ActionController::Base.send :include, ServiceControllerHelper
    end
  end
end
