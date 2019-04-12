# frozen_string_literal: true

module CommandServiceObject
  module ServiceControllerHelper
    def self.included(base)
      base.extend ClassMethods
    end

    def command(service: nil, usecase: action_name)
      service_name = service || self.class.default_service || controller_name

      "#{service_name}/commands/#{usecase}".camelize.constantize
    end

    def execute(cmd)
      ApplicationService.call(cmd)
    end

    module ClassMethods
      @default_service = nil

      def default_service(service_name = nil)
        @default_service ||= service_name
      end
    end
  end
end