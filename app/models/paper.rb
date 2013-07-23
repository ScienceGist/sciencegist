class Paper < ActiveRecord::Base
  store_accessor :metadata, :authors, :journal

  validates_uniqueness_of :identifier
  validates_presence_of :authors
  validates_presence_of :title
  validates_presence_of :journal

  has_many :gists

  def self.find_by_identifier(identifier)
    where('lower(identifier) = lower(?)', identifier).first
  end

  def url
    if identifier =~ /^doi:\s*(.*)/i
      "http://dx.doi.org/#{$1}"
    elsif identifier =~ /^arXiv:\s*(.*)/i
      "http://arxiv.org/abs/#{$1}"
    else
      nil
    end
  end

  def top_gist
    gists.order('cached_votes_score desc').first
  end
end
