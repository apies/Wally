class PostsController < ApplicationController  
  respond_to :json
  
  def index
  	Googler.token = session[:access_token]
  	posts = Googler.fetch_posts(params[:blog_id], 100)
  	#posts = Googler.list_posts(:blogId => params[:blog_id], :maxResults => 20, :pageToken => 'CgkIFBiA5pHosycQ2IiA2PDxoOEg').data
  	#posts = Googler.list_posts(:blogId => params[:blog_id], :maxResults => 20, :pageToken => nil).data
  	render :json => posts.to_json
  end

  # def show
  # 	result = Googler.get_blogs({:blogId => params[:blogId]})
  # end
end
