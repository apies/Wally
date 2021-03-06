require 'spec_helper'
describe GooglerTestingService do
	
	context "stub Googler network calls to the service client" do

		it "can extend Googler and create a service client" do
			#pending
			Googler.extend GooglerTestingService
			Googler.should respond_to(:create_test_client)
			Googler.create_test_client
			Googler.create_client('blogger')
			Googler.client.should_not be_nil
		end

		it "can actually fetch some remote data using the client" do
			#pending
			Googler.extend GooglerTestingService
			Googler.create_test_client
			result = GooglerService.get_blogs(:blogId => 2510490903247292153)
  			result.data['name'].should eq 'Loud Like Bulls'
		end
	end

	context "using object model" do
		
		it "can extend Googler and create a service client" do
			Googler.extend GooglerTestingService
			Googler.should respond_to(:include_test_client)
			Googler.include_test_client
			blogger = Googler.new('fake-t0ken', 'blogger')
			blogger.should respond_to(:_create_client)
			result = blogger.get_blogs(:blogId => 2510490903247292153)
			result.data['name'].should eq 'Loud Like Bulls'

		end
		

	  
	end
	
end