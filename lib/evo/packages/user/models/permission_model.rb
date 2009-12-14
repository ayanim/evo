
class Permission
  
  #--
  # Mixins
  #++
  
  include DataMapper::Resource
  
  #--
  # Properties
  #++
  
  property :id,   Serial
  property :name, String, :length => 8..64, :required => true, :index => true
  
end