
class Evo
  module System
    module Extensions
      
      ##
      # Map added routes to the current package.
      
      def self.route_added verb, path, proc
        Evo::Package.map[proc.__id__] = Evo::Package.current
      end
      
      ##
      # Access to evo's data store.
      
      def store
        Evo.store
      end
      
    end
  end
end

Evo.register Evo::System::Extensions