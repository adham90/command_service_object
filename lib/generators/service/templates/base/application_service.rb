# frozen_string_literal: true

class ApplicationService < ServiceBase
  def call
    ServiceResult.new do
      cmd.class.name.gsub('Commands', 'Usecases').constantize.call(cmd)
    end
  end
end
