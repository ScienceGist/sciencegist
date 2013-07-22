class Paper < ActiveRecord::Base
  # attr_accessible :abstract, :abstract_html, :metadata, :title, :user_id, :identifier
  store_accessor :metadata, :authors
  #serialize :metadata, ActiveRecord::Coders::Hstore

  has_many :gists

  def metadata
    OpenStruct.new(super)
  end


  def author
    if metadata && metadata.author
      metadata.author
    else
      'Unknown'
    end
  end

  def authors
    if metadata && metadata.authors
      metadata.authors
    else
    'Unknown'
    end
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
end
