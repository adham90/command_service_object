# frozen_string_literal: true

class CommandBase
  include Virtus.model
  include ActiveModel::Validations

  # if you need to enable policies add issuer attribute
  # attribute :issuer, User
  # validates :issuer, presence: true
end
