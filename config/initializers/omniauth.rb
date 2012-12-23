Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], {
    access_type: 'offline',
    #scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/calendar' ,
    scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/blogger', 
    redirect_uri:'http://localhost:3000/auth/google_oauth2/callback'
  }


end