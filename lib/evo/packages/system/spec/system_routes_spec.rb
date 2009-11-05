
describe "system" do
  describe "get /public/:package/*" do
    it "should description" do
      get '/public/foo/style.css'
      last_response.should be_ok
      last_response.should have_content_type('text/css')
      last_response.body.should match('super cool')
    end
  end
end