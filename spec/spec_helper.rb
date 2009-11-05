
$:.unshift File.dirname(__FILE__) + '/../lib'
require 'rubygems'
require 'evo'
require 'webrat'
gem 'rack-test', '=0.5.0'
require 'rack/test'

# Boot evolution

Evo.boot! :environment => :test, 
          :root => File.dirname(__FILE__) + '/fixtures/app'

# Spec configuration

Spec::Runner.configure do |c|
  
  # Webrat
  
  c.include Webrat::Methods
  c.include Webrat::Matchers
  
  # Rack::Test
  
  c.include Rack::Test::Methods
  
  ##
  # Reset database
  
  c.before :each do
    DataMapper.auto_migrate!
  end
  
  ##
  # Helpers
  
  c.include Module.new {
    
    # App for Rack::Test
    
    def app
      @app || Evo
    end
    
    # Mock app based on _block_.
    
    def mock_app &block
      subclass = Class.new Evo
      subclass.instance_eval &block
      @app = subclass.new
    end
    
    # Array containing a string matching _val_
    
    def contain val
      simple_matcher "to contain a string matching #{val.inspect}" do |actual|
        actual.any? { |str| str.include?(val) }
      end
    end
    
    # Content-Type matching _type_
    
    def have_content_type type
      simple_matcher "to have Content-Type of #{type.inspect}" do |actual|
        actual['Content-Type'] == type
      end
    end
    
    # String matching n.n.n
    
    def be_a_valid_version
      simple_matcher "to be a valid version matching n.n.n" do |actual|
        actual =~ /\A\d+\.\d+\.\d+\Z/
      end
    end
  }
end

# Run package specs

Evo.spec!
