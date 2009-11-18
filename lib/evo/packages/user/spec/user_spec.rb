
describe User do
  before(:each) { Evo.setup! }
  
  describe "#initialize" do
    it "should assign anonymous role" do
      User.anonymous.should be_anonymous
    end
    
    it "should assign authenticated role" do
      User.first.should be_authenticated
    end
  end
  
  describe "#superuser?" do
    it "should return true when the first user" do
      User.first.should be_superuser
      User.anonymous.should_not be_superuser
      User.new.should_not be_superuser
    end
  end
  
  describe "#save" do
    it "should hash #password" do
      user = User.create :name => 'foobar', :email => 'foo@bar.com', :password => 'something'
      user.password.should == 'something'.to_md5
    end
    
    it "should hash #password_confirmation" do
      user = User.new :name => 'foobar', :email => 'foo@bar.com', :password => 'something'
      user.password_confirmation = 'something'
      user.save
      user.password_confirmation.should == 'something'.to_md5
    end
    
    describe "with :register context" do
      describe "given an invalid format" do
        it "should invalidate the user" do
          user = User.new :name => 'foobar', :email => 'foo@bar.com', :password => 'la la la#$@#'
          user.email_confirmation = 'foo@bar.com'
          user.password_confirmation = 'la la la#$@#'
          user.valid?(:register).should be_false  
        end
      end
      
      describe "given a short password" do
        it "should invalidate the user" do
          user = User.new :name => 'foobar', :email => 'foo@bar.com', :password => 'hey'
          user.email_confirmation = 'foo@bar.com'
          user.password_confirmation = 'hey'
          user.valid?(:register).should be_false
        end
      end
    end
  end
   
  describe "#has_permission?" do
     before :each do
       @user = User.new
       @role = Role.new :name => 'Manager'
       @role.permissions << Permission.new(:name => 'view users')  
       @role.permissions << Permission.new(:name => 'edit users') 
       @user.roles << @role
     end
  
     it "should check a single permission" do
       @user.has_permission?('edit users').should be_true
       @user.may?('edit users').should be_true
       @user.may?('delete users').should be_false
     end
  
     it "should check a several permissions" do
       @user.has_permission?('edit users', 'view users').should be_true
       @user.may?('edit users', 'view users').should be_true
       @user.may?('edit users', 'delete users').should be_false
       @user.may?('delete users', 'view users').should be_false
     end
  end
   
  describe "#==" do
    it "should check if one user is the same as another" do
      User.new(:id => 1).should == User.new(:id => 1)
      User.new(:id => 1).should_not == User.new(:id => 2)
    end
  end
  
  describe ".anonymous" do
    it "should return the anonymous user singleton" do
      User.anonymous.should == User.anonymous
    end
  end
   
  describe ".authenticate" do
    before :each do
      @user = User.create :name => 'foobar', :email => 'foo@bar.com', :password => 'something'
    end
    
    it "should return a user when name and password are valid" do
      User.authenticate('foobar', 'something').should == @user
    end
    
    it "should return a user when email and password are valid" do
      User.authenticate('foo@bar.com', 'something').should == @user
    end
    
    it "should return nil when invalid" do
      User.authenticate('foobar', 'somethings').should be_nil
    end
  end
  
end
