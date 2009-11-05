
describe "system" do
  describe "#messages" do
    it "should store message queue in a session" do
      mock_app do
        get('/user') { messages.to_html }
        delete('/user') { messages.info 'User deleted' }
      end
      delete '/user'
      get '/user'
      last_response.should be_ok
      last_response.body.should include('<li>User deleted</li>')
    end
  end
end