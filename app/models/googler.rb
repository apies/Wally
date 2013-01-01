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
    request_lambda  = Proc.new  do |blog_id, token|
      if token
        list_posts(:blogId => blog_id, :maxResults => 20, :pageToken => token)
      else
        list_posts(:blogId => blog_id, :maxResults => 20)
      end
    end
    @fetcher.fetch_records(blog_id, &request_lambda)
  end

  class Fetcher

    attr_accessor :records, :remainder, :request_count, :next_page_token

    def initialize(desired_records_count)
      @request_count = desired_records_count / 20
      @remainder = desired_records_count % 20
      @records = []
      @next_page_token = ''
    end

    def fetch_records(blog_id, &block)
      until @request_count == 0
        new_query_result = block.call(blog_id, @next_page_token).data
        @records += new_query_result['items'] 
        @next_page_token = new_query_result['nextPageToken']
        @request_count -= 1
      end
      @records += block.call(blog_id, @next_page_token).data['items'][0...@remainder] unless @remainder == 0
      @records
    end
  end



	

end