
require File.dirname(__FILE__) + '/../spec_helper'

describe Evo do
  it "should be Sinatra::Application" do
    Evo.should == Sinatra::Application
  end
  
  it "should default :theme to :chrome" do
    Evo.theme.name.should == :chrome
  end
  
  describe "VERSION" do
    it "should be a triple" do
      Evo::VERSION.should be_a_valid_version
    end
  end
  
  describe ".boot!" do
    it "should raise an error when :root is not present" do
      lambda { Evo.boot! }.should raise_error(Evo::BootError, 'application :root is required')
    end
    
    it "should raise an error when :theme is not a valid theme name" do
      lambda { Evo.boot! :root => File.dirname(__FILE__) + '/../fixtures/app', :theme => :foo }.
      should raise_error(Evo::BootError, 'theme :foo does not exist')
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
  
  describe "#load_themes" do
    it "should load themes" do
      Evo.load_themes
      Evo.loaded_themes.first.should be_a(Evo::Theme)
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