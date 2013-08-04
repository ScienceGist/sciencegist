class IdentifiersController < ApplicationController
  def doi
    @doi = "doi: " + params[:identifiers]
    @paper = Paper.find_by_identifier(@doi)
    unless @paper
      metadata = PaperMetadata.metadata_for(@doi)
      unless metadata[:status] == :NODOI
        @paper = Paper.create!(title: metadata[:title], 
          identifier: @doi, 
          journal: metadata[:journal],
          authors: metadata[:authors])
      end
    end
    render 'papers/show' if @paper
  end

  def arxiv
    @arxiv = "arXiv: " + params[:identifiers]
    @paper = Paper.find_by_identifier(@arxiv)
    unless @paper
      metadata = PaperMetadata.metadata_for(@arxiv)
      unless metadata.blank?
        @paper = Paper.create!(title: metadata[:title], 
          identifier: @arxiv, 
          journal: metadata[:journal],
          authors: metadata[:authors])
      end
    end
    render 'papers/show' if @paper
  end
end
