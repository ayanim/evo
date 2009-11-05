
class Evo
  module System
    module Extensions
      def self.route_added verb, path, proc
        p path
        Evo::Package.map[proc.__id__] = Evo::Package.current
      end
    end
  end
end

Evo.register Evo::System::Extensions