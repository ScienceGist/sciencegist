class IdentifiersController < ApplicationController
  def doi
    @doi = 'doi: ' + params[:identifiers].downcase
    @doi_condensed = 'doi:' + params[:identifiers].downcase
    @paper = Paper.where('lower(identifier) = ? OR lower(identifier) = ?', @doi, @doi_condensed).first
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
    @arxiv = "arxiv: " + params[:identifiers].downcase
    @arxiv_condensed = "arxiv: " + params[:identifiers].downcase
    @paper = Paper.where('lower(identifier) = ? OR lower(identifier) = ?', @arxiv, @arxiv_condensed).first
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
