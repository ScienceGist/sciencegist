class Paper < ActiveRecord::Base
  store_accessor :metadata, :authors, :journal

  validates_uniqueness_of :identifier
  validates_presence_of :authors
  validates_presence_of :title
  validates_presence_of :journal

  has_many :gists

  acts_as_taggable
  
  def self.find_by_identifier(identifier)
    where('lower(identifier) = lower(?)', identifier).first
  end

  def url
    identifier_interpolator('http://dx.doi.org/', 'http://arxiv.org/abs/')
  end

  def identifier_path
    identifier_interpolator('/doi/', '/arxiv/')
  end

  def identifier_interpolator(doi, arxiv)
    if identifier =~ /^doi:\s*(.*)/i
      "#{doi}#{$1}"
    elsif identifier =~ /^arXiv:\s*(.*)/i
      "#{arxiv}#{$1}"
    else
      nil
    end

  end

  def top_gist
    gists.order('cached_votes_score desc').first
  end
end
