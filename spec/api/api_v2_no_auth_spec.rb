require 'spec_helper'

describe Sg::Api do
  before :each do
    @gists = FactoryGirl.create_list(:gist, 40)
  end

  describe 'GET /gists' do
    it 'returns paginated gists' do
      get '/api/v2/gists'
      response.status.should == 200
      body = JSON.parse(response.body)
      body['gists'].count.should == 25
      body['total_pages'].should == 2
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