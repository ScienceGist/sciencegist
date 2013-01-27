class Gist < ActiveRecord::Base
  attr_accessible :content, :content_html, :paper_id, :user_id

  belongs_to :paper
  belongs_to :user

end
