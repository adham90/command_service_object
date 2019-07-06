# frozen_string_literal: true

module CommandServiceObject
  module ModelHelper
    def model_name
      name.camelize
    end

    def model_class
      Object.const_get(model_name)
    rescue StandardError
      nil
    end

    def model_attributes
      return { REPLACE_ME: String } if model_class.nil?

      attrs = {}
      model_class.try(:columns_hash).each do |k, v|
        next if ignored_column_names.include?(k)

        type = allowed_column_types[v.type]
        next if type.nil?

        attrs[k] = type
      end
      attrs
    end

    def ignored_column_names
      %w[
        created_at
        updated_at
        encrypted_password
      ]
    end

    def allowed_column_types
      {
        string: 'String',
        bigint: 'Integer',
        integer: 'Integer',
        decimal: 'Float',
        boolean: 'Boolean',
        datetime: 'DateTime'
      }
    end
  end
end
