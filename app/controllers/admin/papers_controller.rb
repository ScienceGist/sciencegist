class Admin::PapersController < ApplicationController
  layout 'admin/layout'

  def index
    @papers = Paper.order('id desc').all
  end

  def destroy
    @paper = Paper.find(paper_params[:id])
    @paper.destroy
    redirect_to admin_papers_path
  end

  private
  
  def paper_params
    params.permit(:id)
  end

end
