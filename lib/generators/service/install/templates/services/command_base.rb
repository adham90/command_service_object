# frozen_string_literal: true

class CommandBase
  include ActiveModel::Validations
  include Virtus.model

  # if you need to enable policies add issuer attribute
  attribute :issuer, Issuer, default: :default_issuer

  private

  def default_issuer
    nil
  end
end
