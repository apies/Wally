require 'spec_helper' 
#require 'Googler'
describe GooglerService do

	it "can instantiate a service client for testing and services" do
		GooglerService.create_client('blogger')
		GooglerService.service.should_not be_nil
		GooglerService.service.should respond_to(:blogs)
	end

	it "can fetch my Loud Like Bulls Blog Data" do
		result = GooglerService.get_blogs(:blogId => 2510490903247292153)
  		result.data['name'].should eq 'Loud Like Bulls'
	end

end