class PagesController < ApplicationController
  def index
    @public_users = User.where(public: true)
    @gists = Gist.all
  end

  def about
  end

  def example
  end
  
end
