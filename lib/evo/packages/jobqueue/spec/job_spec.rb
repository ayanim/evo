
describe Job do
  before(:each) { Evo.setup! }
  
  describe ".process" do
    before :each do
      @foo = Job.create :type => :mine, :data => ['foo']
      @bar = Job.create :type => :mine, :data => ['bar']
      @baz = Job.create :type => :mine, :data => ['baz'], :status => :failure
      @boo = Job.create :type => :mine, :data => ['boo'], :status => :complete
    end
    
    it "should accept a block, passing an inactive job" do
      Job.process { |job| job.should == @foo }
    end
    
    it "should filter by type when a symbol is passed" do
      Job.process(:mine) { |job| job.should == @foo }
    end
    
    it "should accept an object responding to #call" do
      job_processor = lambda { |job| job.should == @foo }
      Job.process job_processor
    end
    
    it "should accept an object responding to #call as well as a symbol to filter type" do
      job_processor = lambda { |job| job.should == @foo }
      Job.process :mine, job_processor
    end
    
    it "should process by priority" do
      order = []
      a = Job.create :type => :priority, :priority => -5
      b = Job.create :type => :priority, :priority => 5
      c = Job.create :type => :priority
      Job.process(:priority) { |job| order << job }
      Job.process(:priority) { |job| order << job }
      Job.process(:priority) { |job| order << job }
      order.should == [b, c, a]
    end
    
    it "should mark the job as a failure when an error is raised" do
      lambda { Job.process { raise 'foo' }}.should raise_error('foo')
      lambda { Job.process { raise 'foo' }}.should raise_error('foo')
      @foo.reload.status.should == :failure
      @bar.reload.status.should == :failure
      @foo.message.should == 'foo'
      @bar.message.should == 'foo'
    end
    
    it "should mark the job as complete when each process call completes" do
      Job.process {}
      Job.process {}
      @foo.reload.status.should == :complete
      @bar.reload.status.should == :complete
    end
    
    it "should mark the job as active while processing" do
      Job.process { |job| job.status.should == :active }
    end
  end
end