require 'spec_helper'
describe Googler do

  def build_result_mock
    stub_result = double('zoogler')
    stub_result.stub(:data).and_return({'items' => (1..20).to_a, 'nextPageToken' => '324'} )
    boogler = double("googler")
    boogler.stub(:list_posts).and_return(stub_result)
    boogler
  end
  
  
  it 'should know to spawn a fetcher and get ready to que requests' do
  	stub_googler = Googler::Fetcher.new(77)
  	stub_googler.stub(:get_records).and_return([])
  	Googler::Fetcher.should_receive(:new).with(77) {stub_googler}
  	posts = Googler.fetch_posts(12313, 77)
  end

  

  describe Googler::Fetcher

    before :each do
      @google_fetcher = Googler::Fetcher.new(973)
      @google_fetcher_edge = Googler::Fetcher.new(960)
      @google_fetcher_edge2 = Googler::Fetcher.new(17)
    end


    it "google workers should be born with knowledge of their request count and remainder" do
      @google_fetcher.request_count.should be 973/20
      @google_fetcher.remainder.should be 13
      @google_fetcher.records.should eq []
    end

    it 'should know how to get the correct number of posts' do
      #list_posts(:blogId => blog_id, :maxResults => 20, :nextPageToken => next_page_token ||= '')
      boogler = build_result_mock
      posts = @google_fetcher.get_records { boogler.list_posts }
      posts.count.should be 973
      edge_posts = @google_fetcher_edge.get_records { boogler.list_posts }
      edge_posts.count.should be 960
      edge_posts2 = @google_fetcher_edge2.get_records { boogler.list_posts }
      edge_posts2.count.should be 17
    end


  
  
  end