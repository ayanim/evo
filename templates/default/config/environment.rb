
require 'rubygems'
require 'evo'

configure do
  DataMapper.setup :default, "sqlite3:///#{File.expand_path(File.dirname(__FILE__))}/#{Sinatra::Base.environment}.db"
end
