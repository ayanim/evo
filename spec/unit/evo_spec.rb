
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
end