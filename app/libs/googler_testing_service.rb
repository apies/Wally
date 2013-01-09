module GooglerTestingService
	def create_test_client

		#monkey patch create client for testing
		class << self
			alias_method :_create_client, :create_client
			def create_client
				@client = Google::APIClient.new
			    key = Google::APIClient::PKCS12.load_key('./certs/b92e1baa16c1813b73949c7384f38fd79537ed6e-privatekey.p12', 'notasecret')
			    service_account = Google::APIClient::JWTAsserter.new(
			      '342909415861-58lunvc3h6b64b211i17rb0vi95gj5gp@developer.gserviceaccount.com',
			      'https://www.googleapis.com/auth/blogger',
			      key
			    )
			    @client.authorization = service_account.authorize
			    @service = client.discovered_api('blogger', 'v3')
			end
		end

	end
end


