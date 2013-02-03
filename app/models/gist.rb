class Gist < ActiveRecord::Base
  attr_accessible :content, :content_html, :paper_id, :user_id, :paper, :paper_attributes
  belongs_to :paper
  belongs_to :user

  accepts_nested_attributes_for :paper

  validates_presence_of :paper
  validates_presence_of :content

  before_save :render_content

  def author_name
    if user
      user.email
    else
      'Anonymous'
    end
  end

  private

  def render_content
    self.content_html = Kramdown::Document.new(content).to_html
  end
end
