
describe "system" do
  describe "#data" do
    it "should provide access to evolution's datastore" do
      data[:foo] = 'bar'
      data[:foo].should == 'bar'
      data.store :bar, 'baz', :expires_in => 5.minutes
      data[:bar].should == 'baz'
    end
  end
  
  describe "#cache" do
    it "should store data when not previously cached" do
      cache(:page).should be_nil
      cache(:page, 'contents').should == 'contents'
      cache(:page).should == 'contents'
    end
    
    it "should accept a block returning contents" do
      cache(:user).should be_nil
      cache :user do
        'contents'
      end.should == 'contents'
      cache(:user).should == 'contents'
    end
    
    it "should skip the block when cache exists" do
      cache :page, 'contents'
      cache :page do
        'foo bar'
      end.should == 'contents'
      cache(:page).should == 'contents'
    end
    
    it "should delete the cache when a value of nil is passed" do
      cache(:page, 'contents').should == 'contents'
      cache(:page, nil).should be_nil
      cache(:page).should be_nil
    end
    
    it "should accept options defered to #data.store" do
      data.store.should_receive(:store).with(:key, 'value', :expires_in => 1.day)
      cache(:key, 'value', :expires_in => 1.day)
    end
    
    it "should accept :for as an alias of :expires_in" do
      data.store.should_receive(:store).with(:key, 'value', :expires_in => 1.day)
      cache(:key, 'value', :for => 1.day)
    end
  end
  
  describe "#before" do
    it "should become a callback for the given symbol" do
      called = false
      before(:boot) { called = true }
      trigger :before, :boot
      called.should be_true
    end
  end
  
  describe "#trigger" do
    before(:each) { @called = false }
    
    it "should trigger :before the given symbol" do
      before(:boot) { @called = true }
      trigger :before, :boot
      @called.should be_true
    end
    
    it "should trigger :after the given symbol" do
      after(:package_loaded) { @called = true }
      trigger :after, :package_loaded
      @called.should be_true
    end
    
    it "should pass arguments" do
      args = nil
      after(:package_loaded) { |*args| args = args }
      trigger :after, :package_loaded, 'foo', 'bar'
      args.should == ['foo', 'bar']
    end
        
    it "should trigger :before the given symbol when using #before with no block" do
      before(:boot) { @called = true }
      before :boot
      @called.should be_true
    end
    
    it "should trigger :after the given symbol when using #after with no block" do
      after(:package_loaded) { @called = true }
      after :package_loaded
      @called.should be_true
    end
        
    it "should trigger before / after the given block" do
      called_before = false
      called_after = false
      before(:package_loaded) { called_before = true }
      after(:package_loaded) { called_after = true }
      trigger :package_loaded do
        called_before.should be_true
        # ...
      end
      called_after.should be_true
    end
  end
end