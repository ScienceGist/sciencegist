require 'spec_helper'

describe IdentifiersController do

  describe "GET 'doi'" do
    it "returns http success" do
      get 'doi'
      response.should be_success
    end
  end

  describe "GET 'arxiv'" do
    it "returns http success" do
      get 'arxiv'
      response.should be_success
    end
  end

end
