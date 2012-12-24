class BlogsController < ApplicationController
  def index
  	result = Googler.list_blogs_by_user({'userId' => 'self'})
  end

  def show
  	result = Googler.get_blogs({:blogId => params[:blogId]})
  end
end
