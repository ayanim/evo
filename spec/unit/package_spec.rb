
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
  
  describe "#files_in_directory" do
    it "should return recursive list of all files by default" do
      @package.files_in_directory(:spec).should contain('foo_spec.rb')
      @package.files_in_directory(:spec).should contain('nested_foo_spec.rb')
    end
    
    it "should return an empty array when the directory does not exist" do
      @package.files_in_directory(:bar).should be_empty
    end
    
    it "should allow a glob pattern to be passed" do
      @package.files_in_directory(:spec, '*.rb').should contain('foo_spec.rb')
      @package.files_in_directory(:spec, '*.rb').should_not contain('nested_foo_spec.rb')
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