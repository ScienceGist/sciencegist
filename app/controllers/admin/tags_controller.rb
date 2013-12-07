class Admin::TagsController < ApplicationController
  layout 'admin/layout'

  def index
    @tags = ActsAsTaggableOn::Tag.order('id asc').all
    @tag = ActsAsTaggableOn::Tag.new
  end

  def destroy
    @tag = ActsAsTaggableOn::Tag.find(tag_params[:id])
    @tag.destroy
    redirect_to admin_tags_path
  end

  def update
    @tag = ActsAsTaggableOn::Tag.find(tag_params[:id])
    @tag.assign_attributes(tag_params[:acts_as_taggable_on_tag])
    @tag.save
    redirect_to admin_tags_path
  end
  
  def edit
    @tag = ActsAsTaggableOn::Tag.find(tag_params[:id])
  end
  private

  def tag_params
    params.permit(:id, :name, acts_as_taggable_on_tag: [:name])
  end
end
