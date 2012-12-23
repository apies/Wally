module GooglerClientApiWrapper
	
	attr_accessor :token, :move_api
	
	def method_missing(method, *args)
		get_token unless @move_api
		if @move_api.methods.include?(method)
			@move_api.send(method, *args)
		else
			super
		end
	end

	def get_token
		@move_api = MoveApi.new(CONFIG['USERNAME'], CONFIG['PASSWORD'])
    @token = @move_api.get_token
	end
  
  def get_client
		@client = Google::APIClient.new
		@client.authorization.access_token = token
    @service = @client.discovered_api('blogger', 'v3')
    #
  end
  
  def method_missing(method, *args)
    get_client unless @client
		
    result = @client.execute(
    		:api_method => @service.calendar_list.list,
    		:parameters => {},
    		:headers => {'Content-Type' => 'application/json'}
  	)
		@result
  end


end