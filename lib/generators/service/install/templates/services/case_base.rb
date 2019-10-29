# frozen_string_literal: true

class CaseBase
  include CommandServiceObject::FailureHelper
  include CommandServiceObject::Hooks

  attr_reader :cmd
  alias_attribute :payload, :cmd

  def initialize(cmd)
    @cmd = cmd
  end

  def allowed?
    true
  end

  def rollback; end
end
