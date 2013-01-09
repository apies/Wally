class BlogsController < ApplicationController
  respond_to :json


  
  def index
  	Googler.token = session[:access_token]
  	result = Googler.list_blogs_by_user({'userId' => 'self'})
  	render :json => result.data['items'].to_json
  end

  def show
  	Googler.token = session[:access_token]
  	result = Googler.get_blogs({:blogId => params[:id]})
  	render :json => result.data.to_json
  end


  
end
