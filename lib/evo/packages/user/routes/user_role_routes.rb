
helpers do
  def require_assignable_role
    json :message => 'Role is not assignable' unless params[:role_id].to_i > 2
  end
end

##
# Remove user :id's :role_id.
#
# === Permissions
#
#  * 'delete user roles'
#
# === Provides
#
#  * :json
#

delete '/user/*/role', :provides => :json do |id|
  require_permission_to 'delete user roles'
  require_assignable_role
  if join = RoleUser.first(:user_id => id, :role_id => params[:role_id])
    json :status => 1 if join.destroy
  end
  json :message => 'Failed to delete user role'
end

##
# Delete :role_id.
#
# === Permissions
#
#  * 'delete roles'
#
# === Provides
#
#  * :json
#

delete '/user/role', :provides => :json do
  require_permission_to 'delete roles'
  require_assignable_role
  unless foo = Role.get(params[:role_id]).destroy
    json :message => "Failed to delete role #{params[:role_id]}"
  end
end

##
# Create a role with :name.
#
# === Permissions
#
#  * 'create roles'
#
# === Provides
#
#  * :json
#

post '/user/role/?', :provides => :json do
  require_permission_to 'create roles'
  if role = Role.create(:name => params[:name])
    json :status => 1, :id => role.id
  end
  json :message => 'Failed to create role'
end

##
# Assign user :id the :role_id.
#
# === Permissions
#
#  * 'assign user roles'
#
# === Provides
#
#  * :json
#

post '/user/*/role/?', :provides => :json do |id|
  require_permission_to 'assign user roles'
  require_user id
  require_assignable_role
  unless @user.roles.push(Role.get(params[:role_id])) && @user.save
    json :message => 'Failed to add role'
  end
end
