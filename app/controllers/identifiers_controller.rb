class IdentifiersController < ApplicationController
  def doi
    @doi = "doi: " + params[:identifiers]
    @paper = Paper.find_by_identifier(@doi)
    if @paper
      redirect_to paper_path(@paper.id)
    else
      metadata = PaperMetadata.metadata_for(@doi)
      if metadata
        @paper = Paper.create!(title: metadata[:title], 
          identifier: @doi, 
          journal: metadata[:journal],
          authors: metadata[:authors])
        redirect_to paper_path(@paper.id)
      end
    end
  end

  def arxiv
    @arxiv = "arXiv: " + params[:identifiers]
    @arxiv += '.' + params[:format]
    @paper = Paper.find_by_identifier(@arxiv)
    if @paper
      redirect_to paper_path(@paper.id)
    else
      metadata = PaperMetadata.metadata_for(@arxiv)
      if metadata
        metadata[:author] = metadata[:author].split("\n").map do |a| a.strip if a.strip.present?
        end.compact.join(', ')
        @paper = Paper.create!(title: metadata[:title], 
          identifier: @arxiv, 
          journal: metadata[:journal],
          authors: metadata[:author])
        redirect_to paper_path(@paper.id)
      end
    end
  end
end
