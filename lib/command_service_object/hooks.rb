module CommandServiceObject
  module Hooks
    def self.included(base)
      base.send :extend, ClassMethods
      base.send :include, InstanceMethods

      class << base
        alias_method :_new, :new

        define_method :new do |command|
          _new(command).tap do |instance|
            instance.send(:setup_setters, _setters)
            instance.send(:setup_getters, _getters)
          end
        end
      end
    end

    module InstanceMethods
      attr_accessor :_called_setters

      def _called_setters
        @_called_setters ||= []
      end

      def rollback_setters
        _called_setters.reverse_each(&:rollback)
      end

      def setup_getters(getters)
        getters.each do |getter|
          method_name = getter.name.split('::').last.underscore

          define_singleton_method(method_name) do |_payload|
            getter.new.call(args)
          end
        end
      end

      def setup_setters(setters)
        setters.each do |setter|
          method_name = setter.name.split('::').last.underscore

          # unrollable setters
          define_singleton_method("#{method_name}!") do |payload|
            setter.new(payload).call
          end

          # rollable setters
          define_singleton_method(method_name) do |payload|
            obj = setter.new(payload)
            obj.call

            _called_setters << obj
            obj
          end
        end
      end
    end

    module ClassMethods
      cattr_accessor :_getters, :_setters

      def _setters
        @_setters ||= Set.new([])
      end

      def _getters
        @_getters ||= Set.new([])
      end

      def setters(name)
        service = to_s.split('::').first
        obj     = "#{service}/Usecases/Setters/#{name}".camelize.constantize

        _setters.add(obj)
      end

      def getters(name)
        service = to_s.split('::').first
        obj     = "#{service}/Usecases/Getters/#{name}".camelize.constantize

        _getters.add(obj)
      end
    end
  end
end
