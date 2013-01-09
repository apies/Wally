require 'spec_helper'
describe Googler do

	before :all do
		Googler.extend GooglerTestingService
		Googler.create_test_client
	end

	let(:llb_id) { '2510490903247292153'}
	let(:qlh_id) {'2360593805083673688'}

	it "should be able to fetch some data from my blog" do
		result = GooglerService.get_blogs(:blogId => llb_id)
  		result.data['name'].should eq 'Loud Like Bulls'
	end

	it "should be able to fetch 77 posts from the quiet like horses blog" do
		posts = Googler.fetch_post_names_and_ids(qlh_id, 77)
		Googler.fetcher.request_count.should eq 0
		posts.count.should eq 77
		posts.should have_all_unique_ids
		posts = Googler.fetch_post_names_and_ids(qlh_id, 17)
		posts.count.should eq 17
		posts.should have_all_unique_ids
		posts = Googler.fetch_post_names_and_ids(qlh_id, 20)
		posts.count.should eq 20
		posts.should have_all_unique_ids
		posts = Googler.fetch_post_names_and_ids(qlh_id, 60)
		posts.count.should eq 60
		posts.should have_all_unique_ids
	end

end