
class Evo
  module User
    module Helpers

      ##
      # Return current user.
      
      def current_user
        ::User.current
      end
      
      ##
      # Require current user to have _perms_.
      
      def require_permission_to *perms
        unless current_user.may? *perms
          raise "permission denied, user #{current_user.id} may not #{perms.join(', ')}"
        end
      end
      
    end
  end
end

helpers Evo::User::Helpers