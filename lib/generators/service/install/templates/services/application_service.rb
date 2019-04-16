# frozen_string_literal: true

class ApplicationService
  def self.call(cmd)
    ServiceResult.new do
      cmd.class.name.gsub('Commands', 'Usecases').constantize.call(cmd)
    end
  end
end
