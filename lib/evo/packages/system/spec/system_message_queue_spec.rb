
describe Evo::MessageQueue do
  before :each do
    @messages = Evo::MessageQueue.new  
  end
  
  describe "#clear" do
    it "should clear the queue" do
      @messages << 'foo'
      @messages << 'bar'
      @messages.length.should == 2
      @messages.clear
      @messages.length.should == 0
    end
  end
  
  describe "#method_missing" do
    it "should treat the method as the type" do
      @messages.warning 'foo'
      @messages.error 'bar'
      markup = @messages.to_html
      markup.should have_selector('ul.messages.warning > li:contains(foo)')
      markup.should have_selector('ul.messages.error > li:contains(bar)')
    end
    
    it "should return messages for the method when no arguments are provided" do
      @messages.info 'test'
      @messages.error 'foo'
      @messages.error.should == ['foo']
    end
  end
  
  describe "#to_html" do
    it "should return an empty string when empty" do
      @messages.to_html.should == ''  
    end
    
    it "should escape html" do
      @messages << '<script>alert("mwahahaha")</script>'  
      @messages.to_html.should_not have_selector('script')
    end
    
    it "should treat *foo* as <strong>" do
      @messages << 'Welcome *tj*'
      @messages.to_html.should have_selector('strong:contains(tj)')
    end
    
    it "should treat _foo_ as <em>" do
      @messages << 'Welcome _tj_'
      @messages.to_html.should have_selector('em:contains(tj)')
    end
    
    it "should render then clear the queue" do
      @messages << 'foo'
      @messages.to_html
      @messages.length.should == 0
    end
    
    it "should default to :info type" do
      @messages << 'foo'
      @messages.to_html.should have_selector('ul.messages.info')
    end
    
    it "should render a <ul> list per type" do
      @messages.add 'one', :info
      @messages.add 'two', :info
      @messages.add 'three', :error
      markup = @messages.to_html
      markup.should have_selector('ul.messages.info > li:contains(one)')
      markup.should have_selector('ul.messages.info > li:contains(two)')
      markup.should have_selector('ul.messages.error > li:contains(three)')
    end
  end
  
end