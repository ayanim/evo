
describe "system" do
  describe "#javascripts" do
    it "should contain a javascript queue" do
      mock_app do
        get '/' do
          javascripts.add '/system/javascripts/jquery.js'
          javascripts.add '/system/javascripts/jquery.ui.js'
          javascripts.to_html
        end
      end
      get '/'
      last_response.should be_ok
      last_response.body.should include('<script src="/system/javascripts/jquery.js" type="text/javascript"')
      last_response.body.should include('<script src="/system/javascripts/jquery.ui.js" type="text/javascript"')
    end
  end
  
  describe "#messages" do
    it "should contain a session-based message queue" do
      mock_app do
        delete '/user' do 
          messages.info 'User deleted'
        end
        get '/user' do
          messages.to_html
        end
      end
      delete '/user'
      get '/user'
      last_response.should be_ok
      last_response.body.should include('<li>User deleted</li>')
      get '/user'
      last_response.body.should_not include('<li>User deleted</li>')
    end
  end
  
  describe "#regenerate_session" do
    it "should assign a new session token" do
      mock_app do
        get '/' do
          regenerate_session
        end
      end
      get '/' 
      a = last_response.body
      get '/'
      b = last_response.body
      a.should_not == b
    end
  end
end