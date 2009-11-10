
class Evo
  class Package
    
    #--
    # Exceptions
    #++
    
    Error = Class.new StandardError
    InvalidPackageError = Class.new Error
    
    ##
    # Package name symbol.
    
    attr_reader :name
    
    ##
    # Package directory path.
    
    attr_reader :path
    
    ##
    # Package weight.
    
    attr_accessor :weight
    
    ##
    # Natural load weight.
    
    attr_accessor :natural_weight
    
    ##
    # Initialize with _path_ to the package.
    #
    # * Loads <package>/<package>.yml
    #
    
    def initialize path
      @path, @weight = path, 0
      @name = File.basename(path).to_sym
      load_yaml
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
    # Load YAML configuration file.
    #
    # === Options
    # 
    #   :weight    Package weight; lower weights are loaded first, defaults to 0
    # 
    
    def load_yaml
      if has_file? "#{name}.yml"
        YAML.load_file(path / "#{name}.yml").each do |key, val|
          send :"#{key}=", val
        end
      end
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
    # matching the given _glob_ which defaults
    # to recursing and selecting every file.
    
    def files_in_directory name, glob = '**' / '*'
      Dir[path / name / glob]
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
    # Return all replaceable paths to _dir_ with the
    # given file _glob_ pattern. 
    #
    # This method allows other packages to override 
    # views, stylesheets, javascript, and other files
    # while defaulting back to the origin package.
    #
    # === Examples
    # 
    # Lets say that package 'user' contains 'user/views/user.haml',
    # a contib package may create 'foo/views/user/user.haml' or use
    # a different template engine suffix such as 'foo/views/user/user.erb'
    # which will take precedence.
    #
    #  user.replaceable_paths_to(:view, "user.*")
    #  # => '<application>/packages/foo/views/user/user.erb'
    #
    
    def replaceable_paths_to dir, glob
      Evo.loaded_packages.map do |package|
        if self == package
          Dir[package.path / dir / glob]
        else
          Dir[package.path / dir / name / glob]
        end
      end.flatten
    end
    
    ##
    # Return first replaceable path to _dir_ with the 
    # given file _glob_ pattern.
    
    def replaceable_path_to dir, glob
      replaceable_paths_to(dir, glob).first
    end
    
    ##
    # Return all paths to _view_ which disregards engine suffix.
    
    def paths_to_view view
      replaceable_paths_to :views, "#{view}.*"
    end
    
    ##
    # Return first path to _view_ which disregards engine suffix.
    
    def path_to_view view
      paths_to_view(view).first
    end
    
    ##
    # Return all paths to _glob_ which exist.
    
    def paths_to glob
      Evo.paths_to :packages / name / glob
    end
    
    # Partials implementation which includes collections support
    # partial 'photo/_item', :object => @photo
    # partial 'photo/_item', :collection => @photos
    def render_partial template, options = {}
      options.merge! :layout => false
      # path = template.to_s.split(File::SEPARATOR)
      # object_name = path[-1].to_sym
      # path[-1] = "_#{path[-1]}"
      # template_path = File.join(path)
      # raise 'Partial collection specified but is nil' if options.has_key?(:collection) && options[:collection].nil?
      # if collection = options.delete(:collection)
      #   options.delete(:object)
      #   counter = 0
      #   collection.inject([]) do |buffer, member|
      #     counter += 1
      #     options[:locals] ||= {}
      #     options[:locals].merge!(object_name => member, "#{object_name}_counter".to_sym => counter)
      #     buffer << render_template(template_path, options)
      #   end.join("\n")
      # else
      #   if member = options.delete(:object)
      #     options[:locals] ||= {}
      #     options[:locals].merge!(object_name => member)
      #   end
      #   render_template(template_path, options)
      # end
    end
    alias :partial :render_partial
    
    ##
    # Return first path to _glob_.
    
    def path_to glob
      paths_to(glob).first
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
    
    ##
    # Proc / package map.
    
    def self.map
      @map ||= {}
    end
    
    ##
    # Current package.
    
    cattr_accessor :current
    
  end
end