
require File.dirname(__FILE__) + '/../spec_helper'

describe "spec helpers" do
  describe "#app" do
    it "should default to Evo" do
      app.should == Evo
    end
    
    it "should be overridden via @app" do
      @app = 'test'
      app.should == 'test'
    end
    
    it "should reset after each spec" do
      app.should == Evo
    end
  end
  
  describe "#mock_app" do
    it "should subclass Evo" do
      mock_app { environment.should == :not_test }
      app.should_not == Evo
    end
    
    it "should set the current package to :package when passed" do
      mock_app :package => :system do
        get '/' do
          package.name.to_s
        end  
      end
      get '/'
      last_response.body.should == 'system'
    end
  end
end