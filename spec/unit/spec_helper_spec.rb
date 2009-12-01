
require File.dirname(__FILE__) + '/../spec_helper'

describe "spec helpers" do
  before(:each) { Evo.setup! }
  
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
  
  describe "#with_theme" do
    it "should switch the theme for the duration of the block passed" do
      orig = Evo.theme
      with_theme :wahoo do
        Evo.theme.should == Evo::Theme.get(:wahoo)
      end
      Evo.theme.should == orig
    end
  end
  
  describe "#mock_app" do
    it "should subclass Evo" do
      mock_app {}
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
    
    it "should allow testing of sessions" do
      mock_app do
        get '/foo' do
          session[:foo] = 'bar'
          'test'
        end
        
        get '/bar' do
          session[:foo]
        end
      end
      get '/foo'
      get '/bar'
      last_response.body.should == 'bar'
    end
  end
end