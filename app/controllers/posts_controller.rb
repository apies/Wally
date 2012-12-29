class PostsController < ApplicationController
  respond_to :json
  
  def index
  	Googler.token = session[:access_token]
  	# blog = Googler.get_blogs('blogId' => params[:blog_id]).data

  	# posts = Googler.list_posts(:blogId => params[:blog_id], :maxResults => 20)
  	# next_page_token = posts['nextPageToken']

  	# 10.times do 
  	# 	post_items += Googler.list_posts(:blogId => params[:blog_id], :maxResults => 20).data['items']
  	# end



  	#posts = Googler.list_posts(:blogId => params[:blog_id], :maxResults => 20, :nextPageToken => params[:nextPageToken]).data
  	posts = Googler.fetch_posts(params[:blog_id], 940)

  	render :json => posts.to_json
  end

  # def show
  # 	result = Googler.get_blogs({:blogId => params[:blogId]})
  # end
end
