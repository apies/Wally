class SessionsController < ApplicationController
  def create
   session[:access_token] = env['omniauth.auth']['credentials']['token']
   session[:refresh_token] = env['omniauth.auth']['credentials']['refresh_token']
   @user_id = env['omniauth.auth']['uid']

   result = Googler.get_all_posts(env['omniauth.auth']['credentials']['token'])
   render :json => result.data.to_json
   #raise env['omniauth.auth'].to_yaml
  end

  def get_stuff
    Googler.create_api_client
  end

  def get_blog_stuff
    Googler.get_blog_and_post_list
  end

end
