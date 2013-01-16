require 'spec_helper'
describe Googler do

	before :each do
		Googler.extend GooglerTestingService
		Googler.create_test_client
	end

	let(:llb_id) { '2510490903247292153'}
	let(:qlh_id) {'2360593805083673688'}

	context "new object model" do
		#psuedo di for testing
		before :each do
			Googler.extend GooglerTestingService
			Googler.include_test_client
		end


		let(:blogger) {Googler.new('fake-t0ken', 'blogger')}
		it "can get some info about my blogs" do
			
			result = blogger.get_blogs(:blogId => '2510490903247292153')
			result.data['name'].should == 'Loud Like Bulls'
		end

		it "should be able to count the number of posts a blog contains" do
			posts_count = blogger.count_posts(llb_id)
			posts_count.should eq 2
			posts_count.should be_a(Integer)
		end

		it "should be able to fetch 77 posts from the quiet like horses blog" do

			posts = blogger.fetch_post_names_and_ids(qlh_id, 77)
			posts.count.should eq 77
		end

		it "should be able to get all posts for a blog" do
			#pending
			#pending "this example made me realize i was implementing architecture wrong"
			result  = blogger.all_posts(llb_id)
			result.count.should be > 1
			#puts result.to_json
			#.should eq 2
		end



		
	end




	context "Blogs" do

		it "should be able to fetch some data from my blog" do
			result = Googler.get_blogs(:blogId => llb_id)
	  		result.data['name'].should eq 'Loud Like Bulls'
		end

	end
	

	context "Posts" do
		
		it "should be able to count the number of posts a blog contains" do
			posts_count = Googler.count_posts(llb_id)
			posts_count.should eq 2
			posts_count.should be_a(Integer)
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
			posts = Googler.fetch_post_names_and_ids(qlh_id, 2)
			posts.count.should eq 2
			posts.should have_all_unique_ids
		end

		it "should be able to get all posts for a blog" do
			#pending "this example made me realize i was implementing architecture wrong"
			Googler.create_test_client
			Googler.all_posts(llb_id).count.should eq 2
		end

	end

end