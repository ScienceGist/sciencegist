class Admin::PostsController < ApplicationController
  layout 'admin/layout'

  def create
    @post = Post.create(params[:post])
    redirect_to admin_posts_path
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])
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
end
