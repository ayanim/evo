
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
      
      ##
      # Halt with json response _options_.
      
      def json options = {}
        content_type :json
        options[:status] ||= 0
        halt 200, options.to_json
      end
      
    end
  end
end

helpers Evo::System::Helpers