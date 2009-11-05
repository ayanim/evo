
require File.dirname(__FILE__) + '/../spec_helper'

describe Evo::Package do
  before :each do
    @package = Evo::Package.new File.dirname(__FILE__) + '/../fixtures/app/packages/foo'  
  end
  
  describe "#has_directory?" do
    it "should check if a directory exists" do
      @package.should have_directory(:spec)
      @package.should_not have_directory(:bar)
    end
  end
  
  describe "#load_directory" do
    it "should load all *.rb files within the directory" do
      @package.load_directory :spec
      $LOADED_FEATURES.should contain('foo/spec/foo_spec.rb')
      $LOADED_FEATURES.should contain('foo/spec/nested/nested_foo_spec.rb')
    end
  end
end