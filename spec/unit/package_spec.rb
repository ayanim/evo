
require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/shared/all_packages'

describe Evo::Package do
  before :each do
    @package = Evo::Package.new File.dirname(__FILE__) + '/../fixtures/app/packages/foo'
    @jobqueue = Evo::Package.new Evo.core_root + '/packages/jobqueue'
    @path = 'foo'
    @other = @jobqueue
  end
  
  it_should_behave_like 'All packages'
  
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
      Evo::Package.find(:foobar).should == []
    end
  end
  
  describe ".get" do
    it "should find the first package by name" do
      Evo::Package.get(:foo).should be_a(Evo::Package)
      Evo::Package.get('foo').should be_a(Evo::Package)
      Evo::Package.get(:system).should be_a(Evo::Package)
      Evo::Package.get(:foobar).should be_nil
    end
  end
end