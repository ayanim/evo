
require File.dirname(__FILE__) + '/../spec_helper'

describe Evo do
  it "should be Sinatra::Application" do
    Evo.should == Sinatra::Application
  end
  
  describe "VERSION" do
    it "should be a triple" do
      Evo::VERSION.should be_a_valid_version
    end
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
      Evo.package_paths.should contain('app/packages/foo')
      Evo.package_paths.should contain('app/packages/system')
      Evo.package_paths.should contain('evo/packages/system')
    end
  end
  
  describe "#load_packages" do
    it "should load packages" do
      Evo.load_packages
      $LOADED_FEATURES.should contain('foo/routes/foo_routes.rb')
    end
    
    it "should populate #loaded_packages" do
      Evo.loaded_packages.first.should be_a(Evo::Package)
    end
  end
  
  describe "#template_engine_for" do
    it "should return a template engine symbol for the given path" do
      Evo.template_engine_for('foo.haml').should == :haml
      Evo.template_engine_for('foo/bar.haml').should == :haml
      Evo.template_engine_for('foo/bar.haml').should == :haml
      Evo.template_engine_for('foo/bar.html.erb').should == :erb
    end
  end
  
  describe "#parse_options" do
    describe "-x" do
      it "should lock the application" do
        Evo.lock?.should be_false
        Evo.parse_options ['-x']
        Evo.lock?.should be_true
      end
    end
    
    describe "-p port" do
      it "should set the port number" do
        Evo.port.should == 3000
        Evo.parse_options ['-p', '8888']
        Evo.port.should == 8888
      end
    end
    
    describe "-s server" do
      it "should set the server" do
        Evo.parse_options ['-s', 'unicorn']
        Evo.server.should == 'unicorn'
      end
    end
    
    describe "-e env" do
      it "should set the environment" do
        Evo.parse_options ['-e', 'production']
        Evo.environment.should == :production
      end
    end
  end
end