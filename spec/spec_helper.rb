
$:.unshift File.dirname(__FILE__) + '/../lib'
require 'rubygems'
require 'evo'
require 'rack/test'

# Sinatra

configure do
  set :root, File.dirname(__FILE__) + '/fixtures/app'
  set :environment, :test
  set :run, false
  set :raise_errors, true
  set :logging, false
end

# DataMapper

DataMapper.setup :default, 'sqlite3::memory:'

# Spec configuration

Spec::Runner.configure do |c|
  
  ##
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
    def app
      Evo
    end
  }
end
