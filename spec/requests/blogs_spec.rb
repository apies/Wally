require 'spec_helper'

describe "Blogs", js: true do
  describe "Omni Auth Works before getting blogs" do
    it "can click the go to google login button" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit root_path
      page.should have_content("Sign in with Google")
      # save_and_open_page
      #click_link "Sign in with Google"

      #page.should have_content("Allow")
    end
  end
end
