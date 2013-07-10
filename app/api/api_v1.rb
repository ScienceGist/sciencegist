require 'grape'

class ApiV1 < Grape::API

  version 'v1'
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

    desc "Get all gists."
    get do
      gists = Gist.all
      present gists, with: Sg::Entities::Gist
    end

  end
end
