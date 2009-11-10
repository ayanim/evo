
describe Evo::JavaScriptQueue do
  before :each do
    @js = Evo::JavaScriptQueue.new  
  end
  
  describe "#clear" do
    it "should clear the queue" do
      @js << 'foo'
      @js << 'bar'
      @js.length.should == 2
      @js.clear
      @js.length.should == 0
    end
  end
  
  describe "#to_html" do
    describe "when empty" do
      it "should return an empty string" do
        @js.to_html.should == ''
      end
    end
    
    describe "with anything queued" do
      it "should be cleared after" do
        @js << 'foo'
        @js.length.should == 1
        @js.to_html
        @js.length.should == 0
      end
    end
    
    describe "with inline js" do
      it "should output within a <script> tag" do
        @js << 'foo = "bar"'
        markup = @js.to_html
        markup.should include(%(<script type="text/javascript">\n))
        markup.should include('foo = "bar"')
        markup.should include("\n</script>")
      end
      
      it "should output several inline snippits within a <script> tag" do
        @js << 'foo = "bar"'
        @js << 'foo = "baz"'
        markup = @js.to_html
        markup.should include(%(<script type="text/javascript">\n))
        markup.should include(%(foo = "bar";\n))
        markup.should include(%(foo = "baz";\n))
        markup.should include("\n</script>")
      end
    end
    
    describe "with absolute uris" do
      it "should output <script> a tag" do
        @js << 'http://foo.com/bar.js'
        @js.to_html.should have_selector('script[src="http://foo.com/bar.js"]')
      end
      
      it "should output several <script> tags" do
        @js << 'http://foo.com/bar.js'
        @js << '/javascripts/app.js'
        markup = @js.to_html
        markup.should have_selector('script[src="http://foo.com/bar.js"]')
        markup.should have_selector('script[src="/javascripts/app.js"]')
      end
    end
    
    describe "with absolute uris and inline snippits" do
      it "should output both" do
        @js.add 'http://foo.com/app.js'
        @js.add 'foo = "bar"'
        markup = @js.to_html
        markup.should have_selector('script[src="http://foo.com/app.js"]')
        markup.should include(%(<script type="text/javascript">\n))
        markup.should include('foo = "bar"')
        markup.should include("\n</script>")
      end
    end
    
    describe "with :weight options" do
      it "should change the rendering order" do
        @js.add '/three.js', :weight => 5
        @js.add '/two.js'
        @js.add '/one.js', :weight => -5
        markup = @js.to_html
        markup.index('one.js').should < markup.index('two.js')
        markup.index('two.js').should < markup.index('three.js')
      end
    end
    
    describe "with :only option" do
      it "should display only the type listed" do
        @js.add 'http://foo.com/app.js'
        @js.add 'foo = "bar"'
        @js.to_html(:only => :inline).should_not have_selector('script[src="http://foo.com/app.js"]')
        @js.add 'http://foo.com/app.js'
        @js.add 'foo = "bar"'
        @js.to_html(:only => :uri).should_not include('foo = "bar"')
      end
      
      it "should accept an array of types" do
        @js.add 'http://foo.com/app.js'
        @js.add 'foo = "bar"'
        @js.to_html(:only => [:uri, :inline]).should have_selector('script[src="http://foo.com/app.js"]')
        @js.add 'http://foo.com/app.js'
        @js.add 'foo = "bar"'
        @js.to_html(:only => [:uri, :inline]).should include('foo = "bar";')
      end
    end
  end
end