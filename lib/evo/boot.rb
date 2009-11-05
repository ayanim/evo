
class Evo
  
  ##
  # Boot Evolution:
  #
  #  * Loads packages
  #  * Loads config/environments.rb
  # 
  # === Options
  # 
  #   :root      Application root
  #   :verbose   Defaults to false; outputs verbose boot info to stdout
  # 
  
  def self.boot! options = {}
    set :root, options[:root] || raise('application :root is required')
    load_packages
    load_config
    puts "Evolution #{VERSION} started at #{host}:#{port}" if options[:verbose]
  end
  
  ##
  # Path to Evo's core.
  
  def self.core_root
    File.expand_path File.dirname(__FILE__)  
  end
  
  ##
  # Load paths including the application and core.
  
  def self.load_paths
    [root, core_root]
  end
  
  ##
  # Return the first path to _file_.
  
  def self.path_to file
    paths_to(file).first
  end
  
  ##
  # Return all paths to _file_ which exist.
  
  def self.paths_to file
    load_paths.map do |path|
      path / file if File.exists? path / file
    end.compact
  end
  
  ##
  # Return all package paths.
  
  def self.package_paths
    paths_to(:packages).map do |dir|
      Dir[dir / '*']
    end.flatten
  end
  
  ##
  # Load all configuration files.
  
  def self.load_config
    paths_to(:config / 'environment.rb').each do |file|
      require file
    end
  end
  
  ##
  # Return loaded Evo::Package instances.
  
  def self.loaded_packages
    @loaded_packages || []
  end
  
  ##
  # Load all packages within the #load_path's
  # visibility. Populates #loaded_packages.
  
  def self.load_packages
    @loaded_packages = package_paths.map do |dir|
      Package.new(dir).load
    end
  end
  
  ##
  # Load all package specs.
  
  def self.spec!
    loaded_packages.each do |package|
      package.load_directory :spec
    end
  end
end