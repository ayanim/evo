
class Evo
  module User
    module Helpers

      ##
      # Return current user.
      
      def current_user
        ::User.current
      end
      
    end
  end
end

helpers Evo::User::Helpers