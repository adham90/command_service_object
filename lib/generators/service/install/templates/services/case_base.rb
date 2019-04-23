# frozen_string_literal: true

class CaseBase
  include CommandServiceObject::FailureHelper

  attr_reader :payload

  def initialize(payload)
    @payload = payload
  end

  def rollback; end
end
