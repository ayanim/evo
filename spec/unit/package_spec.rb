
require File.dirname(__FILE__) + '/../spec_helper'

describe Evo::Package do
  before :each do
    @package = Evo::Package.new File.dirname(__FILE__) + '/../fixtures/app/packages/foo'
    @jobqueue = Evo::Package.new Evo.core_root + '/packages/jobqueue'
  end
  
  describe "#==" do
    it "should check if two packages have the same name" do
      (@package == @package).should be_true
      (@package == @jobqueue).should be_false
    end
  end
  
  describe "#has_directory?" do
    it "should check if a directory exists" do
      @package.should have_directory(:spec)
      @package.should_not have_directory(:bar)
      @package.should_not have_directory('routes/foo.rb')
    end
  end
  
  describe "#has_file?" do
    it "should check if a file exists" do
      @package.should have_file('routes/foo_routes.rb')
      @package.should_not have_file(:routes)
    end
  end
  
  describe "#files_in_directory" do
    it "should return recursive list of all files by default" do
      @package.files_in_directory(:spec).should contain('foo_spec.rb')
      @package.files_in_directory(:spec).should contain('nested_foo_spec.rb')
    end
    
    it "should return an empty array when the directory does not exist" do
      @package.files_in_directory(:bar).should be_empty
    end
    
    it "should allow a glob pattern to be passed" do
      @package.files_in_directory(:spec, '*.rb').should contain('foo_spec.rb')
      @package.files_in_directory(:spec, '*.rb').should_not contain('nested_foo_spec.rb')
    end
  end
  
  describe "#load_directory" do
    it "should load all *.rb files within the directory" do
      @package.load_directory :spec
      $LOADED_FEATURES.should contain('foo/spec/foo_spec.rb')
      $LOADED_FEATURES.should contain('foo/spec/nested/nested_foo_spec.rb')
    end
  end
  
  describe "#paths_to" do
    it "should return paths available" do
      @package.paths_to(:public / 'style.css').should contain('foo/public/style.css')
    end
  end
  
  describe "#path_to" do
    it "should return the first available path" do
      @package.path_to(:public / 'style.css').should include('foo/public/style.css')
    end
  end
  
  describe "#paths_to_view" do
    it "should return paths available" do
      @package.paths_to_view(:bar).length.should == 2
      @package.paths_to_view(:bar)[0].should include('foo/views/bar.erb')
      @package.paths_to_view(:bar)[1].should include('foo/views/bar.haml')
      @package.paths_to_view(:baz).length.should == 1
      @package.paths_to_view(:hey).length.should == 0
    end
    
    it "should check packages in the load path first" do
      @jobqueue.paths_to_view(:job).length.should == 2
      @jobqueue.paths_to_view(:job)[0].should include('foo/views/jobqueue/job.haml')
      @jobqueue.paths_to_view(:job)[1].should include('jobqueue/views/job.haml')
    end
    
    it "should check packages in the load path first disregarding engine suffix" do
      @jobqueue.paths_to_view(:jobs).length.should == 2
      @jobqueue.paths_to_view(:jobs)[0].should include('foo/views/jobqueue/jobs.erb')
      @jobqueue.paths_to_view(:jobs)[1].should include('jobqueue/views/jobs.haml')
    end
    
    it "should result to returning the original view path" do
      @jobqueue.paths_to_view(:worker).length.should == 1
      @jobqueue.paths_to_view(:worker).first.should include('jobqueue/views/worker.haml')
    end
  end
  
  describe "#path_to_view" do
    it "should return the first available path" do
      @package.path_to_view(:bar).should include('bar.erb')
      @jobqueue.path_to_view(:jobs).should include('foo/views/jobqueue/jobs.erb')
    end
  end
  
  describe ".find" do
    it "should find packages by name" do
      Evo::Package.find(:foo).first.should be_a(Evo::Package)
      Evo::Package.find(:foo).length.should == 1
      Evo::Package.find('foo').length.should == 1
      Evo::Package.find(:system).length.should == 2
    end
  end
  
  describe ".get" do
    it "should find the first package by name" do
      Evo::Package.get(:foo).should be_a(Evo::Package)
      Evo::Package.get('foo').should be_a(Evo::Package)
      Evo::Package.get(:system).should be_a(Evo::Package)
    end
  end
end