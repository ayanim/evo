
class Evo
  module User
    module Extensions
      
      ##
      # Return current user.
      
      def current_user
        ::User.current
      end
      
      ##
      # Shortcut for current_user.setting
      
      def setting *args
        current_user.setting *args
      end
      
    end
  end
end

include Evo::User::Extensions