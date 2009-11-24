

##
# Redirect to the current user's edit page.

get '/user/edit' do
  redirect "/user/#{current_user.id}/edit"
end

##
# Edit the given user :id.
#
# === Permissions
#
#  * 'edit own user account'
#  * 'edit users'
#

get '/user/*/edit/?' do |id|
  require_user id
  require_permission_to current_user == @user ?
    'edit own user account' : 
      'edit users'
  @show_delete = current_user.may? 
    current_user == @user ? 
      'delete own user account' :
        'delete users'
  @show_status = current_user.may? 'edit user status'
  render :edit
end

##
# Update the given user :id and show the edit page.
#
#  * Updates :status independantly; requires 'edit user status'
#
# === Permissions
#
#  * 'edit own user account'
#  * 'edit user status'
#  * 'edit users'
#

put '/user/*/edit/?' do |id|
  require_user id
  case params[:op]
  when 'Delete'
    require_permission_to current_user == @user ?
      'delete own user account' :
        'delete users'
    if @user.destroy
      messages.info 'Account deleted'
      if current_user.may? 'administer users'
        redirect '/users'
      else
        redirect home
      end
    else
      messages.error 'Failed to delete account'
    end
  else
    require_permission_to current_user == @user ?
      'edit own user account' : 
        'edit users'
    params[:user].delete :status unless current_user.may? 'edit user status'
    if @user.update params[:user]
      messages.info 'Account updated successfully'
    else
      messages.error 'Failed to update account'
    end
  end
  redirect back
end