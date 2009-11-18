
before do
  session[:id] ||= token
  sess = Session.first_or_create({ :id => session[:id] }, :hostname => env['REMOTE_ADDR'])
  sess.last_request_at = DateTime.now
  sess.user = User.current = if sess.user
      if sess.user.blocked?
        regenerate_session
        messages.error 'Your account is blocked'
        User.anonymous
      else
        sess.user
      end
    else
      User.anonymous
    end
  sess.save
end

##
# Display user login form.

get '/login/?' do
  render :login
end

##
# Attempt to authenticate a user.

post '/login/?' do
  regenerate_session
  if user = User.authenticate(params[:username], params[:password])
    user.session = Session.create :id => session[:id], :hostname => env['REMOTE_ADDR']
    user.last_login_at = DateTime.now
    if user.session.save && user.save
      messages.info 'Login successful' unless user.blocked?
    end
  else
    messages.error 'Invalid username / password combination'
  end
  render :login
end

##
# Logout the current user.

get '/logout/?' do
  regenerate_session
  messages.info 'Logout successful'
  redirect '/login'
end