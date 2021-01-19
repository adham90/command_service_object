require 'json'

class Util::Json < Virtus::Attribute
  def coerce(value)
    value.is_a?(::Hash) ? value : JSON.parse(value)
  end
end
