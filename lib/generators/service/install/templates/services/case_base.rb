# frozen_string_literal: true

class CaseBase
  include CommandServiceObject::FailureHelper

  attr_reader :cmd
  alias_attribute :payload, :cmd

  def initialize(cmd)
    @cmd = cmd
  end

  def rollback; end
end
