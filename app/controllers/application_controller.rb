class ApplicationController < ActionController::Base
end

class ActionController::Parameters
  def reject_blanks
    reject { |_, value| value.blank? }
  end
end
