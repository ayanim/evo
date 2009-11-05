
configure do
  set :port, 3000
  enable :run
  enable :sessions
  enable :methodoverride
  disable :static
end

configure :test do
  enable :raise_errors
  enable :sessions
  disable :run
  disable :logging
  DataMapper.setup :default, 'sqlite3::memory:'
end