class PostsController < ApplicationController  
  respond_to :json
  
  def index
  	Googler.token = session[:access_token]
  	posts = Googler.fetch_posts(params[:blog_id], 40)
    #binding.pry
    #posts = Googler.fetch_post_names_and_ids(params[:blog_id], 40)
  	render :json => posts.to_json
  end

  def show
  	result = Googler.get_posts(:postId => params[:id])
    render :json => result.data.to_json
  end

  def update
    result = Googler.update_posts(:postId => params[:id], :blogId => params[:blog_id], post => params[:post] )
    render :json => result.to_json
  end




end
