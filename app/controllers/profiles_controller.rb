class ProfilesController < ApplicationController
  def edit
  end

  def update
  end

  def show
    @user = User.find(params[:id])
    @upvoted = @user.find_up_voted_items
    @downvoted = @user.find_down_voted_items
    @wrote = @user.gists.order('cached_votes_score desc')
  end
end
