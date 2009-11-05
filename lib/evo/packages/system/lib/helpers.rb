
class Evo
  module System
    module Helpers
      
      ##
      # Set @package to package _name_ or pass.
      
      def require_package name
        pass unless @package = Evo::Package.get(name) 
      end
      
      ##
      # Set @path to @package's _path_ or pass.
      
      def require_package_path path
        pass unless @path = @package.path_to(path)
      end
      
      ##
      # Message queue.
      
      def messages
        session[:messages] ||= Evo::MessageQueue.new
      end
      
      ##
      # JavaScript queue.
      
      def javascripts
        @javascripts ||= JavaScriptQueue.new
      end
      
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

helpers Evo::System::Helpers