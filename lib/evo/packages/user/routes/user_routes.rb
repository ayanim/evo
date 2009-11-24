
before do
  javascripts.add '/user/javascripts/user.js'
  javascripts.add 'evo.roles = ' + Role.all.to_json
  javascripts.add 'evo.currentUser = ' + current_user.to_json
end

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
  redirect '/login'
end

##
# Logout the current user.

get '/logout/?' do
  regenerate_session
  messages.info 'Logout successful'
  redirect '/login'
end

   
##
# List user accounts.

get '/users/?' do
  require_permission_to 'administer users'
  @users = User.all(:id.not => 2).page params.merge(:order => [:id.asc])
  render :list
end

##
# Deletes the given user :id. 
#
#  * Regenerates the current user's session if deleting self
#
# === Permissions
#
#  * 'delete own user account'
#  * 'delete user'
#
# === Provides
#
#  * :json
#

delete '/user/?', :provides => :json do
  if user = User.get(params[:id])
    if user == current_user
      require_permission_to 'delete own user account'
      regenerate_session
    else
      require_permission_to 'delete users'      
    end
    json :status => user.destroy
  end
  json :message => 'Failed to delete user'
end