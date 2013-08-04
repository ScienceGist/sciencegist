class PapersController < ApplicationController
  before_filter :store_location, only: [:show]

  def show
    @paper = Paper.find(params[:id])
  end

  def index
    if params[:search]
      @tags = ActsAsTaggableOn::Tag.where("name ILIKE ?", "%#{params[:search]}%").limit(5).all.map(&:name)
      @papers = Paper.where("identifier ILIKE ? OR title ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%").page params[:page]
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
