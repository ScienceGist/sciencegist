class PagesController < ApplicationController
  def index
    @gists = Gist.all
  end
end
