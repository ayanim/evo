
describe Menu do
  describe "#initialize" do
    it "should accept a name" do
      Menu.new('Navigation').name.should == 'Navigation'
    end
    
    it "should accept a the :items option" do
      Menu.new('Navigation', :items => ['foo']).items.should == ['foo']
    end
    
    it "should default #items to an empty array" do
      Menu.new('Navigation').items.should == []
    end
    
    it "should not require a name" do
      lambda { Menu.new }.should_not raise_error
    end
  end
  
  describe "#id" do
    it "should return the name as a css compatible id" do
      Menu.new('Some Foo').id.should == 'some-foo'
    end
  end
  
  describe "#<<" do
    it "should add an item" do
      menu = Menu.new
      menu << Menu::Item.new('Login', '/login')
      menu.items.length.should == 1
    end
  end
  
  describe "#to_html" do
    it "should output a <ul> with nested <li>'s" do
      menu = Menu.new :navigation
      articles = Menu::Item.new('Articles', '/articles')
      articles << Menu::Item.new('Web Development', '/articles/web-development')
      menu << Menu::Item.new('Login', '/login')
      menu << Menu::Item.new('Register', '/register')
      menu << Menu::Item.new('Logout', '/logout', :display => false)
      menu << articles
      markup = menu.to_html
      markup.should have_selector('ul[id=navigation]')
      markup.should have_selector('ul > li a[href="/login"]')
      markup.should have_selector('ul > li a[href="/register"]')
      markup.should have_selector('ul > li a[href="/articles"]')
      markup.should have_selector('ul > li > ul > li a[href="/articles/web-development"]')
      markup.should_not have_selector('ul > li a[href="/logout"]')
    end
    
    it "should output by :weight asc" do
      menu = Menu.new :navigation
      menu << Menu::Item.new('Login', '/login', :weight => 80)
      menu << Menu::Item.new('Register', '/register')
      markup = menu.to_html
      markup.should have_selector('ul[id=navigation]')
      markup.should have_selector('ul > li:first-child a[href="/register"]')
      markup.should have_selector('ul > li:nth-child(2) a[href="/login"]')
    end
    
    it "should add .active class when the path matches the given uri" do
      menu = Menu.new :navigation
      menu << Menu::Item.new('Foo', '/foo')
      menu << Menu::Item.new('Bar', '/bar')
      markup = menu.to_html '/foo'
      markup.should have_selector('ul > li.active a[href="/foo"]')
      markup.should have_selector('ul > li a[href="/bar"]')
      markup.should_not have_selector('ul > li.active a[href="/bar"]')
    end
    
    it "should add .active-child class when a menu items child is .active" do
      menu = Menu.new :navigation
      foo = Menu::Item.new('Foo', '/foo')
      foo << Menu::Item.new('Sub Foo', '/foo/bar')
      menu << foo
      menu << Menu::Item.new('Bar', '/bar')
      markup = menu.to_html '/foo/bar'
      markup.should have_selector('ul > li.active-child a[href="/foo"]')
      markup.should have_selector('ul > li.active-child ul li.active a[href="/foo/bar"]')
      markup.should have_selector('ul > li a[href="/bar"]')
      markup.should_not have_selector('ul > li.active a[href="/bar"]')
    end
  end
end