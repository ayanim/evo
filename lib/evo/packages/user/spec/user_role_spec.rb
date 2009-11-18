
describe Role do
  it "should allow permissions" do
    role = Role.create :name => 'Manager'
    role.permissions.create :name => 'edit users'
    role.permissions.create :name => 'delete users'
    role.permissions.length.should == 2
  end
  
  it "should be assignable by default" do
    Role.new(:name => 'Publisher').should be_assignable
  end
  
  it "should be destroyable when assignable" do
    Role.new(:name => 'Publisher').should be_assignable
    Role.new(:name => 'Publisher').should be_destroyable
    Role.new(:name => 'Guest', :assignable => false).should_not be_destroyable
  end
  
  describe "#destroy" do
    it "should destroy destroyable roles only" do
      Role.create(:name => 'foo').destroy.should be_true
      Role.create(:name => 'foo', :assignable => false).destroy.should be_nil
    end
  end
  
  describe "#has_permission?" do
    before :each do
      @role = Role.create :name => 'Manager'
      @role.permissions.create :name => 'view users'
      @role.permissions.create :name => 'edit users'
    end
    
    it "should check a single permission" do
      @role.has_permission?('edit users').should be_true
      @role.may?('edit users').should be_true
      @role.may?('delete users').should be_false
    end
    
    it "should check a several permissions" do
      @role.has_permission?('edit users', 'view users').should be_true
      @role.may?('edit users', 'view users').should be_true
      @role.may?('edit users', 'delete users').should be_false
      @role.may?('delete users', 'view users').should be_false
    end
  end
end