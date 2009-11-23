
##
# Display permission administration page.
#
# === Permissions
#
#  * 'administration permissions'
#

get '/user/permissions/?' do
  require_permission_to 'administer permissions'
  @roles = Role.all
  @permissions = Permission.all
  render :permissions
end

##
# Update permissions.
#
# === Permissions
#
#  * 'administer permissions'
#

post '/user/permissions/?' do
  require_permission_to 'administer permissions'
  unless params[:permissions].blank?
    params[:permissions].each do |role_id, permission_ids|
      next unless role = Role.get(role_id)
      role.update :permissions => Permission.all(:id => permission_ids.keys)
    end
    messages.info 'Updated permissions'
  end
  redirect '/user/permissions'
end

