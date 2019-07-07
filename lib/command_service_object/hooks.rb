module CommandServiceObject
  module Hooks
    def self.included(base)
      base.send :extend, ClassMethods
      base.send :include, InstanceMethods

      class << base
        alias_method :_new, :new

        define_method :new do |command|
          _new(command).tap do |instance|
            instance.send(:setup_micros, _micros)
          end
        end
      end
    end

    module InstanceMethods
      attr_accessor :_called_micros

      def _called_micros
        @_called_micros ||= []
      end

      def rollback_micros
        _called_micros.reverse_each(&:rollback)
      end

      def setup_getters(getters)
        getters.each do |getter|
          method_name = getter.name.split('::').last.underscore

          define_singleton_method(method_name) do |_payload|
            getter.new.call(args)
          end
        end
      end

      def setup_micros(micros)
        micros.each do |micro|
          method_name = micro.name.split('::').last.underscore

          # unrollable micros
          define_singleton_method("#{method_name}!") do |payload|
            micro.new(payload).call
          end

          # rollable micros
          define_singleton_method(method_name) do |payload|
            obj = micro.new(payload)
            obj.call

            _called_micros << obj
            obj
          end
        end
      end
    end

    module ClassMethods
      cattr_accessor :_micros

      def _micros
        @_micros ||= Set.new([])
      end

      def micros(*names)
        service = to_s.split('::').first

        names.each do |name|
          obj = "#{service}/Usecases/Micros/#{name}".camelize.constantize
          _micros.add(obj)
        end
      end
    end
  end
end
