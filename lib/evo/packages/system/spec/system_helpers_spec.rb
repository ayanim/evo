
describe "system" do
  describe "#messages" do
    it "should contain a session-based message queue" do
      mock_app do
        delete '/user' do 
          messages.info 'User deleted'
          messages.to_html
        end
      end
      delete '/user'
      last_response.should be_ok
      last_response.body.should include('<li>User deleted</li>')
    end
  end
end