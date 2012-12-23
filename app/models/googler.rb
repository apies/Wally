require 'google/api_client'
require 'oauth2'

class Googler

	class << self
		attr_accessor :client, :service

		def create_client(token)
			puts 'CREATING CLIENT!'
    		@client = Google::APIClient.new
    		@client.authorization.access_token = token
        @service = @client.discovered_api('blogger', 'v3')
    		#@service = @client.discovered_api('calendar', 'v3')
  		end

  		def get_stuff(token = nil)
  			create_client(token) unless token.nil? 
  				
	  		@result = @client.execute(
	      		:api_method => @service.calendar_list.list,
	      		:parameters => {},
	      		:headers => {'Content-Type' => 'application/json'}
	    	)
	  		@result
	  	end

	  	def get_blog_info(token = nil)
	  		create_client(token) unless token.nil?
	  		@service = @client.discovered_api('blogger', 'v3')
	  		#binding.pry
	  		#2510490903247292153
	  		@result = @client.execute( :api_method => @service.blogs.get, :parameters => {:blogId => ENV['BLOG_ID']},:headers => {'Content-Type' => 'application/json'} )
	    	#json_result = JSON.parse(@result.body)
	    	#binding.pry
	  		@result 
	  	end

	  	def get_all_posts(token = nil)
	  		create_client(token) unless token.nil?
	  		@service = @client.discovered_api('blogger', 'v3')
	  		@result = @client.execute(
	      		:api_method => @service.posts.list,
	      		:parameters => {:blogId => '2360593805083673688', :maxResults => 20},
	      		:headers => {'Content-Type' => 'application/json'}
	    	)
	    	#blog_ids = @result.data['items'].map {|thing| thing['id'] }
	    	@result
        #content_array = @result.data['items'].map {|thing| thing['content'] }
	    	#binding.pry

	  	end

	  	def get_my_user_info(token = nil)
	  		create_client(token) unless token.nil?
	  		params = { :api_method => @service.users.get, :parameters => {'userId' => 'self'}, :headers => {'Content-Type' => 'application/json'}  }
	  		result = @client.execute(params)
	  		@my_blogger_user_id = result.data['id']
	  		@my_blogger_user_url = result.data['url']
	  		@display_name = result.data['displayName'] 
	  	end

	  	#might use this to extract blog ids for other calls
	  	def get_my_blogs(token = nil)
	  		create_client(token) unless token.nil?
	  		params = { :api_method => @service.blogs.list_by_user, :parameters => {'userId' => 'self'}, :headers => {'Content-Type' => 'application/json'}  }
	  		result = @client.execute(params)
	  		#blog_ids = result.data['items'].map {|thing| thing['id'] }
	  		#blog_names = result.data['items'].map {|thing| thing['name'] }
        result
	  	end




	end
	

	# def self.create_oauth_client
	# 	@client = OAuth2::Client.new( ENV['CLIENT_ID'],	ENV['CLIENT_SECRET'] )
	# end




end