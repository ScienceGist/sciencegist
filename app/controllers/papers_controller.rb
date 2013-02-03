class PapersController < ApplicationController
  def show
    @paper = Paper.find(params[:id])
  end

  def metadata
    PaperMetadata.doi_username = 'juretriglav@gmail.com'
    result = PaperMetadata.metadata_for(params[:q])
    binding.pry
    render :json => result
  end
end
