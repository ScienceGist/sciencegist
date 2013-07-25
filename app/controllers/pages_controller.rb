class PagesController < ApplicationController
  def index
    @gists = Gist.all
  end

  def about
  end

  def example
  end
  
end
