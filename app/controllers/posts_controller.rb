require 'pry' 
class PostsController < ApplicationController  

  before_filter :spawn_blogger
  respond_to :json

  def spawn_blogger
    @blogger = Googler.new(session[:access_token], 'blogger')
  end
  
  def index
    posts = @blogger.all_posts(params[:blog_id])
  	render :json => posts.to_json
  end

  def show
  	result = @blogger.get_posts(:blogId => params[:blog_id], :postId => params[:id])
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
    result = Googler.update_posts(:postId => params[:id], :blogId => params[:blog_id], :post => params[:post] )
    render :json => result.to_json
  end




end
