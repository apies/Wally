require 'spec_helper' 
describe Googler do

  def build_result_mock
    stub_result = double('result_mock_thing')
    stub_result.stub(:data).and_return({'items' => (1..20).to_a, 'nextPageToken' => '324'} )
    googler = double("googler")
    googler.stub(:list_posts).and_return(stub_result)
    googler
  end

  def build_big_mock
    mock_client = Google::APIClient.new
    mock_client.stub(:discovered_api)
    stub_result = double('result_mock_thing')
    stub_result.stub(:data).and_return({'items' => (1..20).to_a, 'nextPageToken' => '324'} )
    mock_client.stub(:execute).and_return(stub_result)
    Google::APIClient.should_receive(:new).and_return(mock_client)
    Googler.stub(:build_execution_hash)
  end
  
  
  
  it 'should be able to fetch more than 20 posts with fetch method' do
    build_big_mock
    posts = Googler.fetch_posts(12313, 77)
    posts.count.should be 77
  end

  # it 'should know to spawn a fetcher and get ready to que requests' do
  # 	stub_googler = Googler::Fetcher.new(77)
  # 	stub_googler.stub(:get_records).and_return([])
  # 	Googler::Fetcher.should_receive(:new).with(77) {stub_googler}
  # 	posts = Googler.fetch_posts(12313, 77)
  # end

  

  

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
      Boogler = build_result_mock
      posts = @google_fetcher.fetch_records(1) { Boogler.list_posts }
      posts.count.should be 973
      edge_posts = @google_fetcher_edge.fetch_records(1) { Boogler.list_posts }
      edge_posts.count.should be 960
      edge_posts2 = @google_fetcher_edge2.fetch_records(1) { Boogler.list_posts }
      edge_posts2.count.should be 17
    end


  
  
  end