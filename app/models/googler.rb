require 'google/api_client'
require 'oauth2'
#

class Googler
  
  
  extend GooglerApiWrapper

  class << self
    attr_accessor :fetcher
  end


  def self.fetch_posts(blog_id, number_of_posts)
    @fetcher = Fetcher.new(number_of_posts)
    @fetcher.get_records { list_posts(:blogId => blog_id, :maxResults => 20, :nextPageToken => next_page_token ||= '') }
  end

  class Fetcher

    attr_accessor :records, :remainder, :request_count

    def initialize(desired_records_count)
      @request_count = desired_records_count / 20
      @remainder = desired_records_count % 20
      @records = []
    end

    def get_records(&block)
      #get first n pages
      @request_count.times do
        query_result = block.call.data #get_posts(:blogId => options[:blog_id], :maxResults => 20, :nextPageToken => next_page_token)
        next_page_token = query_result['nextPageToken']
        @records += query_result['items'] 
      end
      #get last page
      @records += block.call.data['items'][0...@remainder] unless @remainder == 0
      @records
    end 
    
  end


  # class << self
  #   attr_accessor :client, :service
  # 
  #   def create_client(token)
  #     puts 'CREATING CLIENT!'
  #         @client = Google::APIClient.new
  #         @client.authorization.access_token = token
  #         @service = @client.discovered_api('blogger', 'v3')
  #         #@service = @client.discovered_api('calendar', 'v3')
  #       end
  # 
  #       def get_stuff(token = nil)
  #         create_client(token) unless token.nil? 
  #           
  #       @result = @client.execute(
  #           :api_method => @service.calendar_list.list,
  #           :parameters => {},
  #           :headers => {'Content-Type' => 'application/json'}
  #       )
  #       @result
  #     end
  # 
  #     def get_blog_info(token = nil)
  #       create_client(token) unless token.nil?
  #       @service = @client.discovered_api('blogger', 'v3')
  #       #binding.pry
  #       #2510490903247292153
  #       @result = @client.execute( :api_method => @service.blogs.get, :parameters => {:blogId => ENV['BLOG_ID']},:headers => {'Content-Type' => 'application/json'} )
  #       #json_result = JSON.parse(@result.body)
  #       #binding.pry
  #       @result 
  #     end
  # 
  #     def get_all_posts(token = nil)
  #       create_client(token) unless token.nil?
  #       @service = @client.discovered_api('blogger', 'v3')
  #       @result = @client.execute(
  #           :api_method => @service.posts.list,
  #           :parameters => {:blogId => '2360593805083673688', :maxResults => 20},
  #           :headers => {'Content-Type' => 'application/json'}
  #       )
  #       #blog_ids = @result.data['items'].map {|thing| thing['id'] }
  #       @result
  #         #content_array = @result.data['items'].map {|thing| thing['content'] }
  #       #binding.pry
  # 
  #     end
  # 
  #     def get_my_user_info(token = nil)
  #       create_client(token) unless token.nil?
  #       params = { :api_method => @service.users.get, :parameters => {'userId' => 'self'}, :headers => {'Content-Type' => 'application/json'}  }
  #       result = @client.execute(params)
  #       @my_blogger_user_id = result.data['id']
  #       @my_blogger_user_url = result.data['url']
  #       @display_name = result.data['displayName'] 
  #     end
  # 
  #     #might use this to extract blog ids for other calls
  #     def get_my_blogs(token = nil)
  #       create_client(token) unless token.nil?
  #       params = { :api_method => @service.blogs.list_by_user, :parameters => {'userId' => 'self'}, :headers => {'Content-Type' => 'application/json'}  }
  #       result = @client.execute(params)
  #       #blog_ids = result.data['items'].map {|thing| thing['id'] }
  #       #blog_names = result.data['items'].map {|thing| thing['name'] }
  #         result
  #     end
  # 
  # 
  # 
  # 
  # end
	





end