class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  before_save :render_body

  validates_presence_of :title
  validates_presence_of :author
  validates_presence_of :content
  validate :published_and_published_at

  scope :published, (lambda do
    where(published: true)
  end)

  def friendly_published_at
    published_at.strftime("%b %d, %Y")
  end

  private

  def published_and_published_at
    if published
      errors[:published_at] << 'Can not be empty if published is true' unless published_at
    end
  end

  def render_body
    renderer = PygmentizeHTML
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    self.html = redcarpet.render self.content
  end
end

class PygmentizeHTML < Redcarpet::Render::HTML
  def block_code(code, language)
    Pygmentize.process(code, language)
  end
end