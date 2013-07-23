class BlogController < ApplicationController
  def index
    @posts = Post.published
  end

  def show
    @show = true
    @post = Post.find_by_slug(params[:id])
    redirect_to(root_path(subdomain: 'blog')) unless @post
  end
end
