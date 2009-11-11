
describe "user" do
  before(:each) { Evo.seed }
  
  describe "get /login" do
    it "should display a login form" do
      get '/login'
      last_response.should be_ok
      last_response.body.should include("name='username'")
      last_response.body.should include("name='password'")
      last_response.body.should include("name='op'")
      last_response.body.should include("value='Login'")
    end
  end
  
  describe "post /login" do
    describe "when unauthenticated" do
      describe "given correct credentials" do
        it "should authenticate the user" do
          post '/login', :username => 'admin', :password => 'password'
          last_response.should be_ok
          User.current.name.should == 'admin'
        end
      end
      
      describe "given invalid credentials" do
        it "should display error messages" do
          post '/login', :username => 'admin', :password => 'invalid password'
          last_response.should be_ok
          User.current.should == User.anonymous
        end
      end
    end
    
    describe "when authenticated" do
      describe "given incorrect credentials" do
        it "should logout the user" do
          User.current = User.first
          post '/login', :username => 'admin', :password => 'invalid password'
          last_response.should be_ok
          User.current.should == User.anonymous
        end
      end
    end
  end
  
end