
class Evo
  module System
    module Helpers
      
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
      
    end
  end
end

helpers Evo::System::Helpers