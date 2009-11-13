
class Evo
  module System
    module SessionHelpers
      
      ##
      # Generate urlencoded random token.
      
      def token
        rand(999999999999).to_s.base64_encode.url_encode
      end
      
      ##
      # Re-generate session token.
      
      def regenerate_session
        session[:id] = token
      end

    end
  end
end

helpers Evo::System::SessionHelpers