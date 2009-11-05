
$:.unshift File.dirname(__FILE__) + '/../lib'
require 'rubygems'
require 'evo'

# Sinatra

configure do
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
  # Reset database
  
  c.before :each do
    DataMapper.auto_migrate!
  end
  
  ##
  # Helpers
  
  c.include do
    def app
      Sinatra::Application
    end
  end
end
