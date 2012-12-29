class SessionsController < ApplicationController
  def create
   session[:access_token] = env['omniauth.auth']['credentials']['token']
   session[:refresh_token] = env['omniauth.auth']['credentials']['refresh_token']
   Googler.token = env['omniauth.auth']['credentials']['token']
   redirect_to root_path
   # @user_id = env['omniauth.auth']['uid']

   # result = Googler.list_blogs_by_user({'userId' => 'self'})
   # render :json => result.data.to_json
   #raise env['omniauth.auth'].to_yaml
  end



end


