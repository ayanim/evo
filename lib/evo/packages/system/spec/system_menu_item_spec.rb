
describe Menu::Item do
  before :each do
    @item = Menu::Item.new 'Login', '/login'  
  end
  
  describe "#initialize" do
    it "should default #display to true" do
      @item.display.should be_true
    end
    
    it "should default #weight to 0" do
      @item.weight.should == 0
    end
    
    it "should allow :weight to be passed" do
      Menu::Item.new('Login', '/login', :weight => -50).weight.should == -50
    end
    
    it "should allow :display to be passed" do
      Menu::Item.new('Login', '/login', :display => false).display.should be_false
    end
    
    it "should allow :when to be passed as :display" do
      Menu::Item.new('Login', '/login', :when => false).display.should be_false
    end
  end
  
  describe "#display?" do
    describe "when #display is a bool" do
      it "should return the bool" do
        @item.display = true
        @item.display?.should be_true
        @item.display = false
        @item.display?.should be_false
      end
    end
    
    describe "when #display is a proc" do
      it "should be called" do
        @item.display = lambda { true }
        @item.display?.should be_true
        @item.display = lambda { false }
        @item.display?.should be_false
      end
    end
    
    describe "when #display is a string" do
      it "should be considered a permission" do
        User.current.roles.first.permissions.create :name => 'view foo'
        @item.display = 'view foo'
        @item.display?.should be_true
        @item.display = 'view bar'
        @item.display?.should be_false
      end
    end
    
    describe "when #display is an array" do
      it "should be considered permissions" do
        User.current.roles.first.permissions.create :name => 'view foo'
        User.current.roles.first.permissions.create :name => 'view bar'
        @item.display = 'view foo', 'view bar'
        @item.display?.should be_true
        @item.display = 'view something else'
        @item.display?.should be_false
      end
    end
    
  end
end