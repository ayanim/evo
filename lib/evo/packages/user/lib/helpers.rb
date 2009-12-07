
class Evo
  module User
    module Helpers

      ##
      # Require current user to have _perms_.
      
      def require_permission_to *perms
        unless current_user.may? *perms
          raise "permission denied, user #{current_user.id} may not #{perms.join(', ')}"
        end
      end
      
      ##
      # Load user _id_ and assigned to @user, or halt
      # with 'User not found' 404.
      
      def require_user id
        not_found 'User not found' unless @user = ::User.get(id)
      end
      
    end
  end
end

helpers Evo::User::Helpers