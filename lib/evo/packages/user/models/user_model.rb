
class User
  
  #--
  # Mixins
  #++
  
  include DataMapper::Resource
  
  ##
  # Current user.
  
  cattr_accessor :current
  
  ##
  # Email confirmation.
  
  attr_accessor :email_confirmation
  
  ##
  # Password confirmation.
  
  attr_accessor :password_confirmation
  
  ##
  # Add authenticated / anonymous roles when appropriate.
  
  def initialize *args
    super
    roles << Role.authenticated if authenticated?
    roles << Role.anonymous if anonymous?
    attribute_set :settings, {}
  end
  
  ##
  # Auto-hash password and confirmation.
  
  before :save do
    return unless new?
    self.password = password.to_md5 unless password.blank?
    self.password_confirmation = password_confirmation.to_md5 unless password_confirmation.blank?
  end
  
  #--
  # Properties
  #++
  
  property :id,            Serial
  property :name,          String,   :length => 2..32, :index => true
  property :password,      String,   :length => 32                 
  property :email,         String,   :length => 6..64, :unique => true
  property :settings,      Json,     :lazy => false
  property :created_at,    DateTime, :index => true
  property :updated_at,    DateTime, :index => true
  property :last_login_at, DateTime, :index => true
  property :status,        Enum[:active, :blocked],  :default => :active, :index => true

  
  #--
  # Validations
  #++
  
  validates_present      :name,     :email,  :when => [:default, :register]
  validates_length       :name => 2..32,     :when => [:default, :register]
  validates_length       :email => 6..64,    :when => [:default, :register]
  validates_length       :password => 6..32, :when => [:default, :register]
  validates_is_unique    :name,     :email,  :when => [:default, :register]
  validates_is_confirmed :password, :when => :register
  validates_format       :password, :as => /\A[\w\d]+\Z/, :when => :register
  validates_is_confirmed :email,    :when => :register
  validates_format       :email,    :as => :email_address, :when => [:default, :register]
  validates_format       :name,     :as => /\A\w+\Z/, :when => [:default, :register]
  
  #--
  # Associations
  #++
  
  has n, :roles, :through => Resource
  has 1, :session
  
  #--
  # Instance methods
  #++
  
  ##
  # Check if all _perms_ are present.
  # The superuser has access to all permissions.
  # 
  # === Examples
  #
  #   user.superuser?                     # => true
  #   user.has_permission? 'edit users'   # => true
  #   
  #   user.superuser?                     # => false
  #   user.has_permission? 'edit users'   # => false
  #   user.may? 'edit users'              # => false
  #
  
  def has_permission? *perms
    return true if superuser?
    roles.any? { |role| role.may? *perms }
  end
  alias :may? :has_permission?
  
  ##
  # Return only roles which have been assigned,
  # excluding anonymous / authenticated roles.
  
  def assigned_roles
    roles.all :id.gt => 2
  end
  
  ##
  # User JSON. Include roles.
  
  def to_json options = {}
    super options.merge(:methods => [:roles])
  end
  
  ##
  # Check if the user is blocked.
  
  def blocked?
    status == :blocked
  end
  
  ##
  # Check if the user is the superuser.
  
  def superuser?
    id == 1
  end
  
  ##
  # Check if the user is authenticated.
  
  def authenticated?
    not anonymous?
  end
  
  ##
  # Check if the user is anonymous.
  
  def anonymous?
    name == 'guest'
  end
  
  ##
  # Anonymous user.
  
  def self.anonymous
    get 2
  end
  
  ##
  # Attempt to authenticate with _name_or_email_, and _password_.
  # Returns the authenticated user, or nil.
  
  def self.authenticate name_or_email, password
    return unless name_or_email && password
    first :conditions => ['password = ? AND (email = ? OR name = ?)', 
      password.to_md5, name_or_email, name_or_email]
  end
  
  ##
  # Get or set setting _key_ with _value_.
  
  def setting key, value = nil
    if value.nil?
      settings[key]
    else
      settings[key] = value
    end
  end
  
end

