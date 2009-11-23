
##
# User registration page.
#
# === Permissions
#
#  * 'create users'
#

get '/register/?' do
  require_permission_to 'create users'
  @user = User.new
  render :register
end

##
# Attempt to register a user.
#
# === Permissions
#
#  * 'create users'
#

post '/register/?' do
  require_permission_to 'create users'
  if (user = User.new params[:user]).save
    messages.info "Registration complete, you may now login as *#{user.name}* or with *#{user.email}*"
    redirect '/login'
  end
  messages.error 'Registration failed'
  redirect '/register'
end