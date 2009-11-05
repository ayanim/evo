
require File.dirname(__FILE__) + '/../spec_helper'

describe Evo do
  it "should be Sinatra::Application" do
    Evo.should == Sinatra::Application
  end
end