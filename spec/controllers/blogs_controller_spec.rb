require 'spec_helper'

describe BlogsController do

  

  describe "#index" do

    before :all do
      Googler.extend GooglerTestingService
      Googler.create_test_client
    end


    it "returns http success" do
      xhr :get, :index, {}
      response.should be_success
    end

    it "returns a list of my blogs" do
      pending "for some reason i cant use id = self with service accounts"
      xhr :get, :index, {}
    end
 end

  describe "#show" do

    let(:llb_id) { '2510490903247292153'}

    it "returns my blog details" do
      xhr :get, :show, :id => llb_id
      JSON.parse(response.body)['name'].should eq "Loud Like Bulls"
      response.should be_success
    end

    it "returns a blog not found or invalid credentials message when an invalid blog id or credential is passed in and message includes params" do
      Googler.token = 'invalidtoken123'
      xhr :get, :show, :id => 'invalid1234232'
      JSON.parse(response.body)['error']['message'].should match(/blogId:invalid1234232/)
    end



  end

end
