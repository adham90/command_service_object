# frozen_string_literal: true

class CommandBase
  include ActiveModel::Validations
  include Virtus.model(nullify_blank: true)

  # if you need to enable policies add issuer attribute
  attribute :issuer, Object, default: :default_issuer

  private

  def default_issuer
    nil
  end
end
