
describe "user" do
  before(:each) { Evo.setup! }
  
  def last_response_should_show_a_login_form
    last_response.body.should include('method="post"')
    last_response.body.should include('name="username"')
    last_response.body.should include('name="password"')
    last_response.body.should include('name="op"')
    last_response.body.should include('value="Login"')
  end
  
  it "should default the user to anonymous on each request" do
    get 'login'
    last_response.should be_ok
    User.current.should == User.anonymous
  end
  
  describe "get /users" do
    it "should raise an error unless the user may 'administer users'" do
      lambda { get '/users' }.should raise_error(/administer users/)
    end
    
    it "should display a table of users" do
      get '/users'
      last_response.should be_ok
      last_response.should have_content_type('text/html')
      last_response.should have_selector('table.users tr#user-1')
    end
    
    it "should not display the guest user" do
      get '/users'
      last_response.should_not have_selector('table.users tr#user-2')
    end
    
    it "should display assignable roles" do
      get '/users'
      last_response.should have_selector('ul.roles')
    end

    it "should not display unassignable roles" do
      get '/users'
      last_response.should_not have_selector('ul.roles li:contains(authenticated)')
      last_response.should_not have_selector('ul.roles li:contains(anonymous)')
    end
  end
  
  describe "get /login" do
    it "should display a login form" do
      get '/login'
      last_response.should be_ok
      last_response_should_show_a_login_form
    end
  end
  
  describe "post /login" do
    describe "when unauthenticated" do
      describe "given correct credentials" do
        it "should authenticate the user" do
          post '/login', :username => 'admin', :password => 'password'
          follow_redirect!
          last_response.should be_ok
          last_response_should_show_a_login_form
          get '/login'
          User.current.should == User.first
        end
      end
      
      describe "given invalid credentials" do
        it "should display error messages" do
          post '/login', :username => 'admin', :password => 'invalid password'
          follow_redirect!
          last_response.should be_ok
          last_response_should_show_a_login_form
        end
      end
    end
    
    describe "when authenticated" do
      describe "given incorrect credentials" do
        it "should logout the user" do
          User.current = User.first
          post '/login', :username => 'admin', :password => 'invalid password'
          follow_redirect!
          last_response.should be_ok
          last_response_should_show_a_login_form
          get '/login'
          User.current.should == User.anonymous
        end
      end
    end
  end
  
end