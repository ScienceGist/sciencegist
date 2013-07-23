class Admin::GistsController < ApplicationController
  layout 'admin/layout'

  def create
    @gist = Gist.create(gist_params[:gist])
    redirect_to admin_gists_path
  end

  def update
    @gist = Gist.find(gist_params[:id])
    @gist.assign_attributes(gist_params[:gist])
    paper = Paper.find_by_identifier(params[:gist][:paper_attributes][:identifier])
    if paper.authors.blank? && gist_params[:gist][:paper_attributes][:title].present?
      paper.update_attributes(gist_params[:gist][:paper_attributes])
    end
    @gist.paper = paper if paper
    @gist.save
    redirect_to admin_gists_path
  end

  def index
    @gists = Gist.all
    @gist = Gist.new
  end

  def show
    @gist = Gist.find(gist_params[:id])
  end

  def edit
    @gist = Gist.find(gist_params[:id])
  end

  def destroy
    @gist = Gist.find(gist_params[:id])
    @gist.destroy
    redirect_to admin_gists_path
  end

  private
  def gist_params
    params.permit(:id, gist: [:id, {paper_attributes: [:identifier, :title, :authors, :journal]}, :content])
  end
end
