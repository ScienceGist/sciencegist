class PagesController < ApplicationController
  def index
    @gists = Gist.all
  end

  def about
  end
end
