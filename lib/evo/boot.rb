
class Evo
  
  ##
  # Boot Evolution:
  #
  #  * Loads packages
  #  * Loads config/environments.rb
  #  * Runs when #run? is true
  # 
  # === Options
  # 
  #   :root      (required) Application root
  #   ...        All other options set attr_writter's
  # 
  # === Examples
  #
  #   Evo.boot! :root => File.dirname(__FILE__) + '/fixtures/app', :environment => :test
  #
  
  def self.boot! options = {}
    set :root, options.delete(:root) || raise('application :root is required')
    options.each { |k, v| send(:"#{k}=", v) if respond_to? :"#{k}=" }
    load_packages
    load_config
    if run?
      parse_options
      run self and puts "== Evolution/#{VERSION}"
    end
  end
  
  ##
  # Parse options from _args_.
  
  def self.parse_options args = ARGV.dup
    return if args.empty?
    require 'optparse'
    OptionParser.new do |op|
      op.on('-x')        {     set :lock, true }
      op.on('-e env')    { |v| set :environment, v.to_sym }
      op.on('-s server') { |v| set :server, v }
      op.on('-p port')   { |v| set :port, v.to_i }
      op.on('--help')    { abort "usage: application.rb [-x] [-e env] [-s server] [-p port]" }
    end.parse! args
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
  # Return the first path to _glob_.
  
  def self.path_to glob
    paths_to(glob).first
  end
  
  ##
  # Return all paths to _glob_ which exist.
  
  def self.paths_to glob
    load_paths.map do |path|
      Dir[path / glob]
    end.flatten.compact
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