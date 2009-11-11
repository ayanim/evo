
describe "user" do
  describe "get /login" do
    it "should display a login form" do
      get '/login'
      last_response.should be_ok
      last_response.should include('name="username"')
      last_response.should include('name="password"')
      last_response.should include('name="op"')
      last_response.should include('>Login<')
    end
  end
end