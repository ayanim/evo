
describe "user" do
  include Evo::User::Helpers
  
  before(:each) { Evo.setup! }
  
  describe "#require_permission_to" do
    it "should raise an error when the current user fails a permission" do
      User.current = User.anonymous
      lambda { require_permission_to 'administer users' }.should raise_error('permission denied, user 2 may not administer users')
    end
    
    it "should raise an error when the current user fails one of several permissions" do
      User.current = User.anonymous
      User.current.roles.first.permissions.create :name => 'view users'
      lambda { require_permission_to 'view users', 'delete users' }.should raise_error('permission denied, user 2 may not view users, delete users')
    end
    
    it "should do nothing when the user has all permissions" do
      User.current = User.anonymous
      User.current.roles.first.permissions.create :name => 'view users'
      User.current.roles.first.permissions.create :name => 'delete users'
      lambda { require_permission_to 'view users', 'delete users' }.should_not raise_error
    end
    
    it "should allow the superuser to do anything" do
      User.current = User.first
      lambda { require_permission_to 'do anything :)' }.should_not raise_error
    end
  end
end