
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
      require file
      self
    end
    
    ##
    # Check if this package has a directory with
    # the given _name_.
    
    def has_directory? name
      File.directory? path / name
    end
    
    ##
    # Return array of files in directory _name_
    # matching the given _pattern_ which defaults
    # to recursing and selecting every file.
    
    def files_in_directory name, pattern = '**' / '*'
      Dir[path / name / pattern]
    end
    
    ##
    # Load all ruby files in directory _name_.
    
    def load_directory name
      files_in_directory(name, '**' / '*.rb').each do |file|
        require file
      end
    end
    
  end
end