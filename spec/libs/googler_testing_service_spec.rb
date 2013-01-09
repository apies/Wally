require 'spec_helper'
describe GooglerTestingService do
	
	context "stub Googler network calls to the service client" do

		it "can extend Googler and create a service client" do
			Googler.extend GooglerTestingService
			Googler.should respond_to(:create_test_client)
			Googler.create_test_client
			Googler.create_client
			Googler.client.should_not be_nil
		end

		it "can actually fetch some remote data using the client" do
			Googler.extend GooglerTestingService
			Googler.create_test_client
			result = GooglerService.get_blogs(:blogId => 2510490903247292153)
  			result.data['name'].should eq 'Loud Like Bulls'
		end
	end
	
end