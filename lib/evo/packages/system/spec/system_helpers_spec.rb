
describe "system" do
  include Evo::System::Helpers
  include Evo::System::PackageHelpers
  include Evo::System::SessionHelpers
  include Evo::System::ViewHelpers
  
  describe "#before" do
    it "should become a callback for the given symbol" do
      called = false
      before(:boot) { called = true }
      trigger :before, :boot
      called.should be_true
    end
  end
  
  describe "#trigger" do
    before(:each) { @called = false }
    
    it "should trigger :before the given symbol" do
      before(:boot) { @called = true }
      trigger :before, :boot
      @called.should be_true
    end
    
    it "should trigger :after the given symbol" do
      after(:package_loaded) { @called = true }
      trigger :after, :package_loaded
      @called.should be_true
    end
    
    it "should pass arguments" do
      args = nil
      after(:package_loaded) { |*args| args = args }
      trigger :after, :package_loaded, 'foo', 'bar'
      args.should == ['foo', 'bar']
    end
        
    it "should trigger :before the given symbol when using #before with no block" do
      before(:boot) { @called = true }
      before :boot
      @called.should be_true
    end
    
    it "should trigger :after the given symbol when using #after with no block" do
      after(:package_loaded) { @called = true }
      after :package_loaded
      @called.should be_true
    end
        
    it "should trigger before / after the given block" do
      called_before = false
      called_after = false
      before(:package_loaded) { called_before = true }
      after(:package_loaded) { called_after = true }
      trigger :package_loaded do
        called_before.should be_true
        # ...
      end
      called_after.should be_true
    end
  end
  
  describe "#path_segments" do
    it "should return the current path's segments as an array" do
      stub!(:request).and_return mock('Request', :path => '/user/2/edit')
      path_segments.should == ['user', '2', 'edit']
    end
  end
  
  describe "#body_classes" do
    it "should return a string of various body classes based on the request" do
      stub!(:path_segments).and_return ['user', '2', 'edit']
      body_classes.should == 'user-2-edit user-2 user '
    end
  end
  
  describe "#javascripts" do
    it "should contain a javascript queue" do
      javascripts.add '/system/javascripts/jquery.js'
      javascripts.add '/system/javascripts/jquery.ui.js'
      markup = javascripts.to_html
      markup.should include('<script src="/system/javascripts/jquery.js" type="text/javascript"')
      markup.should include('<script src="/system/javascripts/jquery.ui.js" type="text/javascript"')
    end
  end
  
  describe "#content_for" do
    it "should buffer contents for a specific region" do
      content_for :header, 'foo'
      content_for :header, 'bar'
      content_for(:header).map(&:to_html).join.should == 'foobar'
    end
    
    it "should buffer regular blocks" do
      content_for :header do
        'Testing'
      end
      content_for(:header).map(&:to_html).join.should include('Testing')
    end
    
    it "should clear the buffer after each request" do
      mock_app do
        get '/' do
          content_for :header, 'foo'
          content_for :header, 'bar'
          content_for :header, 'baz'
          content_for(:header).map(&:to_html).join
        end
        
        get '/other' do
          content_for(:header).map(&:to_html).join
        end
      end
      get '/'
      last_response.body.should_not be_empty
      get '/other'
      last_response.body.should be_empty
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
      mock_app :package => :foo do
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
  
  describe "#capture" do
    it "should capture strings" do
      results = capture do
        'test'
      end
      results.should == 'test'
    end
    
    it "should capture haml" do
      mock_app :package => :foo do
        get '/' do
          render :capture_haml
        end
      end
      get '/'
      last_response.body.should have_selector('div > h2:contains(Yay)')
    end
  end
  
  describe "#render_block" do
    it "should provide an api to the :_block partial" do
      mock_app :package => :system do
        get '/' do
          render_block 'System', 'description', :classes => 'foo' do
            'body'
          end
        end
      end
      get '/'
      last_response.body.should have_selector('div.block.foo')
      last_response.body.should have_selector('div .heading h2:contains(System)')
      last_response.body.should have_selector('div .heading p.description:contains(description)')
      last_response.body.should have_selector('div .body:contains(body)')
    end
  end
  
  describe "#render_layout" do
    it "should raise Evo::LayoutMissingError when the layout does not exist" do
      with_theme :invalid do
        mock_app :package => :foo do
          get '/' do
            render_layout :page
          end
        end
      lambda { get '/' }.should raise_error(Evo::LayoutMissingError, /layout :page does not exist/)
      end
    end
    
    it "should render the layout when present" do
      mock_app do
        get '/' do
          render_layout :page
        end
      end
      get '/'
      last_response.body.should include('<html>')
    end
    
    it "should allow yield :sym to output a region" do
      with_theme :wahoo do
        mock_app :package => :foo do
          get '/' do
            content_for :header, 'Welcome'
            content_for :header, 'to our site'
            content_for :primary, 'Im content'
            render :bar
          end
        end
        get '/'
        last_response.body.should include("<h2>Welcome to our site</h2>")
        last_response.body.should include('Im content')
      end
    end
  end
  
  describe "#render" do
    it "should render a view" do
      mock_app :package => :foo do
        get '/' do
          render :bar 
        end
      end
      get '/'
      last_response.body.should include('im erb')
    end
    
    it "should escape haml buffers by default" do
      mock_app :package => :foo do
        get '/' do
          render :malicious 
        end
      end
      get '/'
      last_response.body.should_not include("<script>alert('rawr')</script>")
    end
    
    it "should render the page layout" do
      with_theme :wahoo do
        mock_app :package => :foo do
          get '/' do
            render :bar
          end
        end
        get '/'
        last_response.body.should include('<html>')
      end
    end
    
    it "should not render the page layout when :layout is false" do
      with_theme :wahoo do
        mock_app :package => :foo do
          get '/' do
            render :bar, :layout => false
          end
        end
        get '/'
        last_response.body.should_not include('<html>')      
        last_response.body.should include('im erb')  
      end    
    end
    
    it "should output region blocks by :weight" do
      with_theme :wahoo do
        mock_app :package => :foo do
          get '/' do
            content_for :header, 'to our site', :weight => -5
            content_for :header, 'Welcome', :weight => -10
            content_for :primary, 'Im content'
            render :regions 
          end
        end
        get '/'
        last_response.body.should include("<h2>Welcome to our site</h2>")
        last_response.body.should include('Im content')
      end
    end
        
    it "should allow nesting view directories" do
      mock_app :package => :foo do
        get '/' do
          render :'items/list'
        end
      end
      get '/'
      last_response.body.should include('list of items')
    end
    
    it "should give precedence to the current theme" do
      with_theme :wahoo do
        mock_app :package => :foo do
          get '/' do
            render :print, :layout => false
          end
        end
        get '/'
        last_response.should be_ok
        last_response.body.should include('overridden!')
      end
    end
  end
  
  describe "#render_partial" do
    it "should populate a local variable when :object is used" do
      mock_app do
        get '/' do
          partial :item, :object => package
        end
      end
      get '/'
      last_response.body.should == "<h2>foo</h2>\n"
    end
    
    it "should render the partial several times when a :collection is passed" do
      mock_app do
        get '/' do
          partial :item, :collection => [package, package]
        end
      end
      get '/'
      last_response.body.should == "<h2>foo</h2>\n\n<h2>foo</h2>\n"
    end
    
    it "should render the partial server times evaluating against :context when :collection is passed" do
      mock_app do
        get '/' do
          partial :context, :collection => [package, package], :context => true
        end
      end
      get '/'
      last_response.body.should == "<h2>foo</h2>\n\n<h2>foo</h2>\n"      
    end
    
    it "should allow nesting view directories" do
      mock_app do
        get '/' do
          partial :'items/item', :object => package
        end
      end
      get '/'
      last_response.body.should include('foo')
    end
    
    it "should render views relative to :package when passed" do
      mock_app do
        get '/' do
          partial :item, :object => package, :package => ::Evo::Package.get(:system)
        end
      end
      get '/'
      last_response.body.should == "<p>foo</p>\n"
    end
    
    it "should evaluate against the given :context when passed" do
      mock_app do
        get '/' do
          partial :context, :context => package
        end
      end
      get '/'
      last_response.body.should include('<h2>foo</h2>')
    end
  end
end