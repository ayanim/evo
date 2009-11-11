
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
  
  describe "#content_for" do
    it "should buffer contents for a specific region" do
      mock_app do
        get '/' do
          content_for :header, 'foo'
          content_for :header, 'bar'
          content_for(:header).map(&:to_html).join
        end
      end
      get '/'
      last_response.body.should == "foobar"
    end
    
    it "should buffer regular blocks" do
      mock_app do
        get '/' do
          content_for :header do
            'Testing'
          end
          content_for(:header).map(&:to_html).join
        end
      end
      get '/'
      last_response.body.should include('Testing')
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
    
    it "should allow yield :sym to output a region" do
      mock_app :package => :foo do
        get '/' do
          content_for :header, 'Welcome'
          content_for :header, 'to our site'
          content_for :primary, 'Im content'
          render :regions 
        end
      end
      get '/'
      last_response.body.should include("Welcome to our site\n")
      last_response.body.should include('Im content')
    end
    
    it "should output region blocks by :weight" do
      mock_app :package => :foo do
        get '/' do
          content_for :header, 'to our site', :weight => -5
          content_for :header, 'Welcome', :weight => -10
          content_for :primary, 'Im content'
          render :regions 
        end
      end
      get '/'
      last_response.body.should include("Welcome to our site\n")
      last_response.body.should include('Im content')
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