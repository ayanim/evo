
class Evo
  module System
    module PackageHelpers
      
      ##
      # Set current package when evaluating a route _block_.
      
      def route_eval &block
        Evo::Package.current = Evo::Package.map[block.__id__]
        super
      end
      
      ##
      # Return current package.
      
      def package
        Evo::Package.current
      end
      
      ##
      # Set @package to package _name_ or pass.
      
      def require_package name
        pass unless @package = Evo::Package.get(name) 
      end
      
      ##
      # Set @path to @package's _dir_ matching _glob_ or pass.
      
      def require_package_path dir, glob
        pass unless @path = @package.replaceable_path_to(dir, glob)
      end
      
    end
  end
end

helpers Evo::System::PackageHelpers