
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
  end
end