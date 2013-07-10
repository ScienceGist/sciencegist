module Sg
  module Entities
    class User < Grape::Entity
      expose :email
    end

    class Paper < Grape::Entity
      format_with(:iso_timestamp){ |dt| dt.iso8601 }

      expose :identifier
      expose :title
      expose :metadata
      expose :abstract
      expose :abstract_html
      expose :user, using: User      

      with_options({ :format_with => :iso_timestamp })do
        expose :created_at
        expose :updated_at
      end
    end

    class Gist < Grape::Entity
      format_with(:iso_timestamp){ |dt| dt.iso8601 }

      expose :id
      expose :content
      expose :content_html

      expose :user, using: User
      expose :paper, using: Paper

      with_options({ :format_with => :iso_timestamp }) do
        expose :created_at
        expose :updated_at
      end
    end

  end

end