
require File.dirname(__FILE__) + '/../spec_helper'

describe Evo do
  it "should be Sinatra::Application" do
    Evo.should == Sinatra::Application
  end
  
  describe "#load_paths" do
    it "should start with the application" do
      Evo.load_paths.first.should include('app')
    end
    
    it "should end with core" do
      Evo.load_paths.last.should include('evo')
    end
  end
  
  describe "#path_to" do
    it "should return the first matching path" do
      Evo.path_to('config/environment.rb').should include('app/config/environment.rb')
    end
  end
  
  describe "#paths_to" do
    it "should return all matching paths" do
      paths = Evo.paths_to 'config/environment.rb'
      paths.first.should include('app/config/environment.rb')
      paths.last.should include('evo/config/environment.rb')
    end
  end
  
  describe "#package_paths" do
    it "should return array of paths to all packages" do
      Evo.package_paths.any? { |p| p.match('app/packages/foo') }.should be_true
      Evo.package_paths.any? { |p| p.match('app/packages/system') }.should be_true
      Evo.package_paths.any? { |p| p.match('evo/packages/system') }.should be_true
    end
  end
  
  describe "#load_packages!" do
    it "should load packages" do
      Evo.load_packages!
      $LOADED_FEATURES.should contain('foo/foo.rb')
    end
    
    it "should populate #loaded_packages" do
      Evo.loaded_packages.first.should be_a(Evo::Package)
    end
  end
end