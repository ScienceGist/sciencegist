class Post < ActiveRecord::Base
  attr_accessible :author, :content, :title, :published

  before_save :render_body

  private

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