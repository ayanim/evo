
require File.dirname(__FILE__) + '/../spec_helper'

describe Evo do
  it "should be Sinatra::Application" do
    Evo.should == Sinatra::Application
  end
  
  describe "#package_load_path" do
    it "should start with the application" do
      Evo.package_load_path.first.should include('app/application/packages')
    end
    
    it "should end with core" do
      Evo.package_load_path.last.should include('evo/packages')
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
end