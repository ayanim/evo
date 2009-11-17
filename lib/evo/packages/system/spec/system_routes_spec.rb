
describe "system" do
  describe "#package" do
    it "should reference the current package" do
      get '/foo'
      last_response.should be_ok
      last_response.body.should == 'foo'
    end
  end
  
  describe "get /theme/*" do
    it "should transfer a file from the current theme when present" do
      with_theme :wahoo do
        get '/theme/style.css'
        last_response.should be_ok
        last_response.should have_content_type('text/css')
        last_response.body.should include('im a style')
      end
    end
  end
  
  describe "get /:package/*" do
    it "should transfer a file when it is present" do
      get '/foo/foo.txt'
      last_response.should be_ok
      last_response.should have_content_type('text/plain')
      last_response.body.should include('super cool')
    end
    
    it "should pass when not present" do
      get '/foo/something.png'
      last_response.should_not be_ok
    end
    
    it "should be overridable" do
      get '/system/javascripts/jquery.js'
      last_response.should be_ok
      get '/system/javascripts/jquery.ui.js'
      last_response.should be_ok
      last_response.body.should include('overriden!')
      last_response.should have_content_type('application/javascript')
    end
  end
  
  describe "get /:package/*.css" do
    it "should pass regular css through" do
      get '/foo/style.css'
      last_response.should be_ok
      last_response.should have_content_type('text/css')
      last_response.body.should include('body {')
    end
    
    it "should compile sass files" do
      get '/foo/print.css'
      last_response.should be_ok
      last_response.should have_content_type('text/css')
      last_response.body.should include('body {')
    end
  end
end