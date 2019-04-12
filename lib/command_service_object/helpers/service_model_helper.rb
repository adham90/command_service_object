# frozen_string_literal: true

module CommandServiceObject
  module ServiceModelHelper
    def model_name
      name.camelize
    end

    def model_class
      Object.const_get(model_name) rescue nil
    end

    def model_attributes
      return { REPLACE_ME: String } if model_class.nil?

      attrs = Hash.new
      model_class.columns_hash.each do |k, v|
        next if ignored_column_names.include?(k)

        type = allowed_column_types[v.type]
        next if type.nil?

        attrs[k] = type
      end
      attrs
    end

    def ignored_column_names
      [
        'created_at',
        'updated_at',
        'encrypted_password'
      ]
    end

    def allowed_column_types
      {
        string: "String",
        bigint: "Integer",
        integer: "Integer",
        decimal: "Float",
        boolean: "Boolean",
        datetime: "DateTime"
      }
    end
  end
end