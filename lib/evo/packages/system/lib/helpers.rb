
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
      
    end
  end
end

helpers Evo::System::Helpers