require 'spec_helper' 

describe Googler::Fetcher do 

  let(:googler) do
    stub_result = double('result_mock_thing')
    stub_result.stub(:data).and_return({'items' => (1..20).to_a, 'nextPageToken' => '324'} )
    googler = double("googler")
    googler.stub(:list_posts).and_return(stub_result)
    googler
  end

  context "in isolation" do

    let(:google_fetcher)  { Googler::Fetcher.new(973) }
    let(:google_fetcher_edge) { Googler::Fetcher.new(960) }
    let(:google_fetcher_edge2)  { Googler::Fetcher.new(17) }
    let(:google_fetcher_edge3)  { Googler::Fetcher.new(77) }


    it "google workers should be born with knowledge of their request count and remainder" do
      google_fetcher.request_count.should be 48
      google_fetcher.remainder.should be 13
      google_fetcher.records.should eq []
    end

    it 'should know how to get the correct number of posts' do
      posts = google_fetcher.fetch_records(1) { googler.list_posts }
      posts.count.should be 973
      edge_posts = google_fetcher_edge.fetch_records(1) { googler.list_posts }
      edge_posts.count.should be 960
      edge_posts2 = google_fetcher_edge2.fetch_records(1) { googler.list_posts }
      edge_posts2.count.should be 17
      edge_posts3 = google_fetcher_edge3.fetch_records(1) { googler.list_posts }
      edge_posts3.count.should be 77
    end
  end

  context "stubbed out googler using the fetcher" do

    # before :each do
    #   stub_client_wrapper_but_not_fetcher
    # end

    it 'should be able to fetch more than 20 posts with fetch method' do
      pending "for some reason I can stub out all of googler when run running from sublime but rake errors"
      stub_client_wrapper_but_not_fetcher
      
      # Googler.stub(:list_posts).and_return( 1..77.to_a)
      # Googler.should_receive(:build_api_method).with('posts', 'list').and_return(googler)
      # googler.should_receive(:execute).and_return([])
      # Googler.client = 
      # Google::APIClient.should_receive(:new)

      # googler
      # Googler.token = 'TOKENHERE'

      # #Googler.should_receive(:list_posts).and_return({'items' => (1..20).to_a, 'nextPageToken' => '324'})
      # Googler.should_receive(:fetch_records).with(12313) {googler.list_posts}

      posts = Googler.fetch_posts(12313, 77)



      posts.count.should be 77
    end

  end

  end