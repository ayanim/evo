
describe "user" do
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
end