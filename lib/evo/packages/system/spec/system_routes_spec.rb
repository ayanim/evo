
describe "system" do
  describe "get /:package/public/*" do
    it "should transfer a file when it is present" do
      get '/foo/public/style.css'
      last_response.should be_ok
      last_response.should have_content_type('text/css')
      last_response.body.should match('super cool')
    end
    
    it "should respond with 404 when not present" do
      get '/foo/public/something'
      last_response.should_not be_ok
    end
  end
end