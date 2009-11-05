
class Evo
  class Package
    
    ##
    # Package name symbol.
    
    attr_reader :name
    
    ##
    # Package directory path.
    
    attr_reader :path
    
    ##
    # Initialize with _path_ to the package.
    
    def initialize path
      @path = path
      @name = File.basename(path).to_sym
    end
    
    ##
    # Load the package:
    #
    #  * Loads <package>/lib
    #  * Loads <package>/models
    #  * Loads <package>/routes
    #
    
    def load
      load_directory :lib
      load_directory :models
      load_directory :routes
      self
    end
    
    ##
    # Check if this package has a directory with
    # the given _name_.
    
    def has_directory? name
      File.directory? path / name
    end
    
    ##
    # Check if this package has a regular file
    # with the given _name_.
    
    def has_file? name
      File.file? path / name
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
    
    ##
    # Check if this package is the same as _other_.
    
    def == other
      name == other.name
    end
    
    ##
    # Return all paths to _view_ which disregards engine suffix.
    
    def paths_to_view view
      Evo.loaded_packages.map do |package|
        if self == package
          Dir[package.path / :views / "#{view}.*"]
        else
          Dir[package.path / :views / name / "#{view}.*"]
        end
      end.flatten
    end
    
    ##
    # Return first path to _view_ which disregards engine suffix.
    
    def path_to_view view
      paths_to_view(view).first
    end
    
    ##
    # Return all paths to _file_ which exist.
    
    def paths_to file
      Evo.paths_to :packages / name / file
    end
    
    ##
    # Return first path to _file_.
    
    def path_to file
      paths_to(file).first
    end
    
    ##
    # Find package(s) by _name_.
    
    def self.find name
      Evo.loaded_packages.select do |package|
        package.name == name.to_sym
      end
    end
    
    ##
    # Get first package by _name_.
    
    def self.get name
      find(name).first
    end
    
  end
end