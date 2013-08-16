require 'spec_helper'

describe Sg::Api do
  before :each do
    @gists = FactoryGirl.create_list(:gist, 40)
  end

  describe 'GET /gists' do
    it 'returns all gists' do
      get '/api/v1/gists'
      response.status.should == 200
      JSON.parse(response.body).count.should == 40
    end
  end

  describe 'GET /gist/:id' do
    it 'returns 1 gist' do
      @gist = Gist.last
      get "/api/v2/gists/#{@gist.id}"
      response.status.should == 200
      body = JSON.parse(response.body)
      body.count.should == 7 # Properties
      body['content'].should == @gist.content 
    end
  end
end