class Issuer
  include ActiveModel::Validations
  include Virtus.model

  attribute :id, String
  attribute :type, String
  attribute :scope, Array[String], default: []

  validates :id, :type, presence: true
end
