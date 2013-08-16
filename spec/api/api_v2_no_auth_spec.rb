require 'spec_helper'

describe Sg::API do
  before :all do
    @gists = FactoryGirl.create(:gist, 40)
  end

  describe 'GET /gists' do
    it 'returns paginated gists' do
      get '/api/v2/gists'
      response.status.should == 200
      JSON.parse(response.body)['gists'].count.should == 25
    end
  end

  describe 'GET /gist/:id' do
    it 'returns 1 drug' do
      get "/api/v2/drugs/#{Gist.last.id}"
      response.status.should == 200
      JSON.parse(response.body).count.should == 7
    end
  end
end