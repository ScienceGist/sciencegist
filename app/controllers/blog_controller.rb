class BlogController < ApplicationController
  def index
    @posts = Post.published
  end
end
