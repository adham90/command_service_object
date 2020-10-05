# frozen_string_literal: true

require 'hutch'

class CaseBase
  include CommandServiceObject::Hooks
  include CommandServiceObject::FailureHelper
  include CommandServiceObject::CheckHelper

  attr_reader :cmd, :issuer, :right_name
  alias_attribute :payload, :cmd

  def initialize(cmd)
    @cmd = cmd
    @issuer = cmd.try(:issuer)
    @right_name = "#{service_name}.#{case_name}"
  end

  def case_name
    self.class.name.split('::').last.downcase
  end

  def service_name
    self.class.name.split('::').first.remove('Service').downcase
  end

  def allowed?
    true
  end

  def rollback; end
end
