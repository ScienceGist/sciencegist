class PapersController < ApplicationController
  before_filter :store_location, only: [:show]

  def show
    @paper = Paper.find(params[:id])
  end

  def index
    if params[:search]
      @papers = Paper.where("identifier ILIKE ? OR title ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @papers = []
    end
  end

  def metadata
    result = PaperMetadata.metadata_for(params[:q])
    if result && result[:title]
      render :json => result
    else
      render :json => nil, status: 404
    end
  end
end
