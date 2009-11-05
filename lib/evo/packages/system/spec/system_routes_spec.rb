
describe "system" do
  describe "get /:package/*" do
    it "should transfer a file when it is present" do
      get '/foo/style.css'
      last_response.should be_ok
      last_response.should have_content_type('text/css')
      last_response.body.should match('super cool')
    end
    
    it "should pass when not present" do
      get '/foo/something.png'
      last_response.should_not be_ok
    end
  end
end