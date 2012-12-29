class BlogsController < ApplicationController
  respond_to :json
  
  def index
  	Googler.token = session[:access_token]
  	result = Googler.list_blogs_by_user({'userId' => 'self'})
  	render :json => result.data.to_json
  end

  # def show
  # 	result = Googler.get_blogs({:blogId => params[:blogId]})
  # end
end
