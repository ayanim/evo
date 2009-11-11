
class Session
  
  #--
  # Mixins
  #++
  
  include DataMapper::Resource
  
  #--
  # Properties
  #++
  
  property :id,              String,   :length => 6..128, :key => true, :unique => true
  property :hostname,        String,   :length => 6..128, :index => true
  property :last_request_at, DateTime, :index => true
  property :data,            Object
  
  #--
  # Associations
  #++
  
  belongs_to :user
  
  #--
  # Class methods
  #++
  
  ##
  # Destroy sessions older than _date_ which defaults to 3.hours.ago.
  
  def self.reap date = 3.hours.ago
    all(:last_request_at.lt => date).destroy
  end
  
end