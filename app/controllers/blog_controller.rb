class BlogController < ApplicationController
  def index
    @posts = Post.all
  end
end
