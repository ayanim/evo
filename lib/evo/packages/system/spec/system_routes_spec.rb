
describe "system" do
  describe "get /:pacage/public/*" do
    it "should transfer a file when it is present" do
      get '/public/foo/style.css'
      last_response.should be_ok
      last_response.should have_content_type('text/css')
      last_response.body.should match('super cool')
    end
  end
end