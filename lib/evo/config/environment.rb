
configure do
  set :port, 3000
  enable :sessions
  enable :methodoverride
end

configure :test do
  enable :raise_errors
  disable :run
  disable :logging
  DataMapper.setup :default, 'sqlite3::memory:'
end