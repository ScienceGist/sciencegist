class PapersController < ApplicationController
  def show
    @paper = Paper.find(params[:id])
  end

  def index
    if params[:search]
      @papers = Paper.where("identifier ILIKE ?", "%#{params[:search]}%")
    else
      @papers = []
    end
  end

  def metadata
    PaperMetadata.doi_username = 'juretriglav@gmail.com'
    result = PaperMetadata.metadata_for(params[:q])
    render :json => result
  end
end
