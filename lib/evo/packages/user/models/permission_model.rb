
class Permission
  
  #--
  # Mixins
  #++
  
  include DataMapper::Resource
  
  #--
  # Properties
  #++
  
  property :id,   Serial
  property :name, String, :length => 8..64, :nullable => false, :index => true
  
  #--
  # Class methods.
  #++
  
  ##
  # Provided permissions.
  
  def self.provided
    @permissions ||= []
  end
  
  ##
  # Provide one or more _perms_.
  
  def self.provide *perms
    @permissions = provided | perms
  end
  
  ##
  # Create provided permissions.
  
  def self.create_provided!
    provided.each do |perm|
      create :name => perm
    end
  end

end