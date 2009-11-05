
class Evo
  class Package
    
    ##
    # Package name symbol.
    
    attr_reader :name
    
    ##
    # Package directory path.
    
    attr_reader :path
    
    ##
    # Package initialization file path.
    
    attr_reader :file
    
    ##
    # Initialize with _path_ to the package.
    
    def initialize path
      @path = path
      @name = File.basename(path).to_sym
      @file = path / name + '.rb'
    end
    
    ##
    # Load the package.
    
    def load!
      load file
      self
    end
  end
end