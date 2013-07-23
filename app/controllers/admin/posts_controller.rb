class Admin::PostsController < ApplicationController
  layout 'admin/layout'

  def create
    @post = Post.create(post_params[:post])
    redirect_to admin_posts_path
  end

  def update
    @post = Post.find_by_slug(post_params[:id])
    @post.update_attributes(post_params[:post])
    redirect_to admin_posts_path
  end

  def index
    @posts = Post.all
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end

  private
  def post_params
    params.permit(:id, post: [:author, :published, :published_at, :content])
  end

end
