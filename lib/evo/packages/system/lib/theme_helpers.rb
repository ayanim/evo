
class Evo
  module System
    module ThemeHelpers

      ##
      # Return current theme.
      
      def theme
        Evo.theme
      end
      
      ##
      # Set @path to #theme's _dir_ matching _glob_ or pass.
      
      def require_theme_path dir, glob
        pass unless @path = theme.replaceable_path_to(dir, glob)
      end
      
    end
  end
end

helpers Evo::System::ThemeHelpers