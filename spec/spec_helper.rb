
$:.unshift File.dirname(__FILE__) + '/../lib'
require 'rubygems'
require 'evo'

# Sinatra

Sinatra::Base.set :environment, :test
Sinatra::Base.set :run, false
Sinatra::Base.set :raise_errors, true
Sinatra::Base.set :logging, false

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
