
class Evo
  class Theme < Package
    
    ##
    # Return loaded theme instances.
    
    def self.instances
      Evo.loaded_themes
    end
    
    ##
    # Return all paths to _glob_ which exist.
    
    def paths_to glob
      Evo.paths_to :themes / name / glob
    end
    
    ##
    # Return all replaceable paths to _dir_ with the
    # given file _glob_ pattern. 
    #
    # This method allows other packages to override 
    # views, stylesheets, javascript, and other files
    # while defaulting back to the origin theme.
    #
    # === Examples
    # 
    # Lets say that core theme 'chrome' contains 'public/javascripts/chrome.js',
    # our application may create 'chrome/public/javascripts/chrome.js'
    # which will take precedence and be transfered instead of the original.
    #
    #  chrome.replaceable_paths_to(:public, "javascripts/chrome.js")
    #  # => '<application>/themes/chrome/public/javascripts/chrome.js'
    #
    
    def replaceable_paths_to dir, glob
      self.class.find(name).map do |theme|
        Dir[theme.path / dir / glob]
      end.flatten
    end
    
  end
end