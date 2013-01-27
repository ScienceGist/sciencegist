class Gist < ActiveRecord::Base
  attr_accessible :content, :content_html, :paper_id, :user_id, :paper, :paper_attributes
  belongs_to :paper
  belongs_to :user

  accepts_nested_attributes_for :paper


end
