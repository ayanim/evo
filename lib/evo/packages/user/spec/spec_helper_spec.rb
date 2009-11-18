
describe "user" do
  describe "#with_user" do
    it "should switch the user for the duration of the block passed" do
      get '/login'
      User.current.should be_anonymous
      with_user 1 do
        get '/login'
        User.current.should be_superuser
      end
      User.current.should be_anonymous
    end
  end
end