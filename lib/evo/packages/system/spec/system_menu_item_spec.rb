
describe Menu::Item do
  before :each do
    @item = Menu::Item.new 'Login', '/login'  
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
        grant_permissions 'view foo' do 
          @item.display = 'view foo'
          @item.display?.should be_true
          @item.display = 'view bar'
          @item.display?.should be_false
        end
      end
    end
    
    describe "when #display is an array" do
      it "should be considered permissions" do
        grant_permissions 'view foo', 'view bar' do 
          @item.display = 'view foo', 'view bar'
          @item.display?.should be_true
          @item.display = 'view something else'
          @item.display?.should be_false
        end
      end
    end
    
  end
end