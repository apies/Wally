module GooglerApiWrapper
	
	attr_accessor :token, :service, :client
  
  def get_method_hash(method_string)
    method_match = method_string.match(/([a-z]+)[_]([a-z]+)[_]*(.*)/)
    model = method_match[2]
    unless method_match[3].empty?
      method = "#{method_match[1]}_#{method_match[3]}"
    else
      method = method_match[1]
    end
    {
      :model => model,
      :method => method
    }
  end
  
  def build_api_method(model, method)
    api_method = @service.send(model).send(method)
  end
	
  def build_execution_hash(method_string, params)
    method_hash = get_method_hash(method_string)
    api_method = build_api_method(method_hash[:model], method_hash[:method])
    
    { :api_method => api_method, :parameters => params, :headers => {'Content-Type' => 'application/json'}  }
  end
  
  def create_client
  	@client = Google::APIClient.new
  	@client.authorization.access_token = @token
    @service = @client.discovered_api('blogger', 'v3')
  end
  
  def method_missing(method, *args)
    return super unless args[0]
    create_client unless @client
    params = args[0]
    execution_hash = build_execution_hash(method.to_s, params)
    result = @client.execute(execution_hash)
  end
    



end