 require 'google/api_client'
 require 'rspec/mocks'
 module GooglerHelpers
 	def stub_client_wrapper_but_not_fetcher
 	  mock_client = Google::APIClient.new
      mock_client.stub(:discovered_api)
      stub_result = double('result_mock_thing')
      stub_result.stub(:data).and_return({'items' => (1..20).to_a, 'nextPageToken' => '324'} )
      mock_client.stub(:execute).and_return(stub_result)
      Google::APIClient.stub(:new).and_return(mock_client)
      Googler.stub(:build_execution_hash)
 	end
 end