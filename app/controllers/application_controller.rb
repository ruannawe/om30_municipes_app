class ApplicationController < ActionController::Base
  include Pagy::Backend
end

class ActionController::Parameters
  def reject_blanks
    reject { |_, value| value.blank? }
  end
end
