
class Role
  
  #--
  # Mixins
  #++
  
  include DataMapper::Resource
  
  #--
  # Properties
  #++
  
  property :id,         Serial
  property :name,       String,  :length => 2..32, :required => true, :index => true
  property :assignable, Boolean, :default => true
  
  #--
  # Associations
  #++
  
  has n, :permissions, :through => Resource
  
  #--
  # Instance methods
  #++
  
  ##
  # Check if this role has _perms_.
  
  def has_permission? *perms
    permissions.map(&:name).includes_all? *perms
  end
  alias :may? :has_permission?
  
  ##
  # Allow destroying of assignable roles only.
  
  def destroy
    return unless destroyable?
    super
  end
  
  ##
  # Check if the role is assignable. For example
  # 'anonymous' and 'authenticated' are system controlled
  # and may not be manually assigned or destroyed.
  
  alias :assignable? :assignable
  
  ##
  # Check if the role is destroyable.
  
  alias :destroyable? :assignable?
  
  ##
  # Role JSON. Include permissions.
  
  def to_json options = {}
    super options.merge(:methods => [:permissions])
  end
  
  #--
  # Class methods.
  #++
  
  ##
  # Return authenticated role.
  
  def self.authenticated
    first :name => 'authenticated'
  end
  
  ##
  # Return anonymous role.
  
  def self.anonymous
    first :name => 'anonymous'
  end
  
  ##
  # Return all assignable roles.
  
  def self.assignable options = {}
    all({ :assignable => true }.merge(options))
  end
  
end