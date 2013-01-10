require 'spec_helper'

describe BlogsController do

  

  describe "#index" do

    before :all do
      Googler.extend GooglerTestingService
      Googler.create_test_client
      #stub_request(:get, "https://www.googleapis.com/discovery/v1/apis/blogger/v3/rest").
       #   with(:headers => {'Accept'=>'*/*', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'google-api-ruby-client/0.5.0 Mac OS X/10.8.2'}).
        #  to_return(:status => 200, :body => "", :headers => {})
    end


    it "returns http success" do
      xhr :get, :index, {}
      response.should be_success
    end

    it "returns a list of my blogs" do
      xhr :get, :index, {}
    end
 end

  describe "#show" do

    let(:llb_id) { '2510490903247292153'}

    it "returns http success" do
      xhr :get, :show, :id => llb_id
      JSON.parse(response.body)['name'].should eq "Loud Like Bulls"
      response.should be_success
    end
  end

end
