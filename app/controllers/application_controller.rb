class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery

  def after_sign_up_path_for(resource)
    session.delete(:return_to) || super
  end

  def after_sign_in_path_for(resource)
    session.delete(:return_to) || super
  end
end
