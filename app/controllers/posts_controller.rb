require 'pry'
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
  	result = Googler.get_posts(:blogId => params[:blog_id], :postId => params[:id])
    if result.data['error']
      render :json => {
        :error => {
          :message => "unfortunately either blog with blog_id:#{params[:blog_id]}post_id:#{params[:id]} was not found" + 
            " or your access_token #{session[:access_token]} is invalid"
        }
      }
    else
      render :json => result.data.to_json
    end
  end

  def update
    result = Googler.update_posts(:postId => params[:id], :blogId => params[:blog_id], post => params[:post] )
    render :json => result.to_json
  end




end
