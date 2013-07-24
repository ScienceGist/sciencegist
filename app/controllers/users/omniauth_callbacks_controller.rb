class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    @user = User.find_for_twitter_oauth(request.env["omniauth.auth"], current_user)
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "your Twitter") if is_navigational_format?
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"]
      flash[:notice] = 'We are unable to log you in. Let us know at info@sciencegist.com'
      redirect_to root_path
    end
  end
end