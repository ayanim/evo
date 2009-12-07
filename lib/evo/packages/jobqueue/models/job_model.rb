
class Job
  
  #--
  # Mixins
  #++
  
  include DataMapper::Resource
  
  #--
  # Properties
  #++
  
  property :id,         Serial
  property :type,       String,   :length => 2..64, :nullable => false, :index => true
  property :message,    String,   :length => 255
  property :status,     Enum[:complete, :failure, :active, :inactive], :default => :inactive, :index => true
  property :priority,   Integer,  :index => true, :default => 0
  property :created_at, DateTime, :index => true
  property :updated_at, DateTime, :index => true
  property :data,       Json,     :lazy => false
  
  #--
  # Class methods
  #++
  
  ##
  # Process jobs with _object_ or _block_. Optionally
  # specify the _type_ of job to process.
  #
  # When processing begins the job status is set to :active, 
  # when an error is raised it is then set to :failure, otherwise
  # to :complete.
  #
  # === Examples
  #    
  #   Job.process do |job|
  #     // ... work with job.data
  #   end
  #
  #   Job.process CustomWorker.new
  #   
  #   Job.process(:emails) { |job| }
  #   
  #   Job.process :emails, CustomWorker.new
  #
  
  def self.process type = nil, object = nil, &block
    object, type = type, nil unless Symbol === type
    params = { :status => :inactive, :order => [:priority.desc] }
    params.merge!({ :type => type }) if type
    if job = first(params)
      begin
        job.update :status => :active
        (object || block).call job
      rescue Exception => e
        job.update :status => :failure, :message => e.message
      else
        job.update :status => :complete
      end
    end
  end
  
  #--
  # Instance methods
  #++
  
  ##
  # Check if the job has been completed.
  
  def completed?
    status == :completed
  end
  
  ##
  # Check if the job has failed.
  
  def failed?
    status == :failure
  end
  
  ##
  # Check if the job is active.
  
  def active?
    status == :active
  end
  
end