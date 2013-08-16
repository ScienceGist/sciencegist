require 'spec_helper'

describe Sg::API do
  before :all do
    @gists = FactoryGirl.create(:gist, 40)
  end

  describe 'GET /gists' do
    it 'returns all gists' do
      get '/api/v1/gists'
      response.status.should == 200
      JSON.parse(response.body).count.should == 40
    end
  end

  describe 'GET /gist/:id' do
    it 'returns 1 drug' do
      get "/api/v1/drugs/#{Gist.last.id}"
      response.status.should == 200
      JSON.parse(response.body).count.should == 7
    end
  end
end