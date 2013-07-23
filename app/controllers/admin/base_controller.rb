class Admin::BaseController < ApplicationController
  before_filter :authenticate_user!
  before_filter :verify_admin

  layout 'admin/layout'

  def index
    @user = current_user
    @user_count = User.count
    @paper_count = Paper.count
    @gist_count = Gist.count
  end

  def verify_admin
    if !current_user.admin?
      flash[:error] = "You must be logged in as admin"
      redirect_to new_user_session_path
    end
  end
end
