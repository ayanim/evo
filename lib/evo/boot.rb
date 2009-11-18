
class Evo
  
  #--
  # Exceptions
  #++
  
  Error = Class.new StandardError
  SetupError = Class.new Error
  BootError = Class.new Error

  ##
  # Initialize Evolution:
  #
  #  * Setup database
  #  * Seed database
  #
  # === See
  #
  #  * Evo.seed
  #
  
  def self.setup!
    DataMapper.auto_migrate! and seed
  end
  
  ##
  # Boot Evolution:
  #
  #  * Loads configuration
  #  * Loads packages
  #  * Loads themes
  #  * Sets the current theme instance derived from Evo.theme
  #  * Runs when #run? is true
  # 
  # === Options
  # 
  #   :root      (required) Application root
  #   :theme     Active theme name, defaults to :chrome
  #   ...        All other options are passed to #set
  # 
  # === Examples
  #
  #   Evo.boot! :root => File.dirname(__FILE__) + '/fixtures/app', :environment => :test
  #
  # === See
  # 
  #  * Evo.load_config
  #  * Evo.load_packages
  #  * Evo.load_themes
  #  * Evo.parse_options
  # 
  # === Raises
  #
  #  * Evo::BootError
  #
  
  def self.boot! options = {}
    set :root, options.delete(:root) || raise(BootError, 'application :root is required')
    set options
    load_config
    load_packages
    load_themes
    set :theme, Evo::Theme.get(theme) || raise(BootError, "theme #{theme.inspect} does not exist")
    if run?
      parse_options
      run self and puts "== Evolution/#{VERSION}"
    end
  end
  
  ##
  # Seed the database with pre-canned data.
  #
  # * Creates anonymous Role
  # * Creates authenticated Role
  # * Creates admin User
  # * Create provided permissions
  # 
  
  def self.seed
    seed_roles; seed_users; seed_permissions
  end
  
  ##
  # Seed the database with pre-canned roles.
  #
  # * Creates anonymous Role
  # * Creates authenticated Role
  # 
  
  def self.seed_roles
    ::Role.create :name => 'anonymous', :assignable => false
    ::Role.create :name => 'authenticated', :assignable => false
  end
  
  ##
  # Seed the database with pre-canned users.
  #
  # * Creates admin User
  # * Creates anonymous User
  # 
  
  def self.seed_users
    raise SetupError, ':admin_email required' unless admin_email?
    raise SetupError, ':admin_password required' unless admin_password?
    ::User.create :name => 'admin', :email => admin_email, :password => 'password'
    ::User.create :name => 'guest', :email => admin_password, :anonymous => true
  end
  
  def self.seed_permissions
    Package.instances.each do |package|
      next unless package.permissions
      package.permissions.each do |permission|
        ::Permission.create :name => permission
      end
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
    end.flatten
  end
  
  ##
  # Return immediate directories within _path_.
  
  def self.directories_in path
    paths_to(path).map do |dir|
      Dir[dir / '*']
    end.flatten
  end
  
  ##
  # Return all package paths.
  
  def self.package_paths
    directories_in :packages
  end
  
  ##
  # Return all theme paths.
  
  def self.theme_paths
    directories_in :themes
  end
  
  ##
  # Load all configuration files.
  
  def self.load_config
    paths_to(:config / 'environment.rb').reverse.each do |file|
      require file
    end
  end
  
  ##
  # Return loaded Evo::Theme instances.
  
  def self.loaded_themes
    @loaded_themes || []
  end
  
  ##
  # Load all themes within #load_path's visibility.
  # Populates #loaded_themes.
  
  def self.load_themes
    @loaded_themes = theme_paths.map do |dir|
      Evo::Theme.new dir
    end
  end
  
  ##
  # Return loaded Evo::Package instances.
  
  def self.loaded_packages
    @loaded_packages || []
  end
  
  ##
  # Return all Evo::Package instances.
  
  def self.packages
    n = -1
    @packages ||= package_paths.map do |dir|
      package = Evo::Package.new dir
      package.natural_weight = n += 1
      package 
    end.sort_by(&:weight)
  end
  
  ##
  # Load all packages within the #load_path's
  # visibility. Populates #loaded_packages.
  
  def self.load_packages
    @loaded_packages = packages.map do |package|
      Evo::Package.current = package and package.load
    end.sort_by(&:natural_weight)
  end
  
  ##
  # Load all package specs.
  
  def self.spec!
    loaded_packages.each do |package|
      package.load_directory :spec
    end
  end
  
end