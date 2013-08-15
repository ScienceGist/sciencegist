require 'grape'

module Sg
  class ApiV2 < Grape::API

    version 'v2'
    format :json
    prefix 'api'

    resource :gists do
      desc "Return a gist."
      params do
        requires :id, type: Integer, desc: "Gist id."
      end
      route_param :id do
        get do
          gist = Gist.find(params[:id])
          present gist, with: Sg::Entities::Gist
        end
      end

      desc "Get gists in pages of 25 at a time."
      params do
        optional :page, type: Integer, default: 1
      end
      get do
        gists = Gist.page(params[:page])
        present :total_pages, gists.total_pages
        present :page, gists.current_page
        present :gists, gists, with: Sg::Entities::Gist
      end
    end
  end
end
