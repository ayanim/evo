
shared_examples_for 'All packages' do
  describe "#==" do
    it "should check if two packages have the same name" do
      (@package == @package).should be_true
      (@package == @other).should be_false
    end
  end
  
  describe "#has_directory?" do
    it "should check if a directory exists" do
      @package.should have_directory(:spec)
      @package.should_not have_directory(:bar)
      @package.should_not have_directory('routes/foo.rb')
    end
  end
  
  describe "#has_file?" do
    it "should check if a file exists" do
      @package.should have_file('spec/foo_spec.rb')
      @package.should_not have_file('spec/foo_spec')
      @package.should_not have_file(:routes)
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
      $LOADED_FEATURES.should contain(@path + '/spec/foo_spec.rb')
      $LOADED_FEATURES.should contain(@path + '/spec/nested/nested_foo_spec.rb')
    end
  end
  
  describe "#paths_to" do
    it "should return paths available" do
      @package.paths_to(:public / 'style.css').should contain(@path + '/public/style.css')
    end
  end
  
  describe "#path_to" do
    it "should return the first available path" do
      @package.path_to(:public / 'style.css').should include(@path + '/public/style.css')
    end
  end
end