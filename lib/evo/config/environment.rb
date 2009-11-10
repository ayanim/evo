
configure do |app|
  set :port, 3000
  set :theme, :chrome
  set :haml, :escape_html => true
  enable :run
  enable :sessions
  enable :methodoverride
  disable :static
  DataMapper.setup :default, "sqlite3:///#{app.root}/databases/evo.#{app.environment}.db"
end

configure :test do
  enable :raise_errors
  enable :sessions
  disable :run
  disable :logging
  DataMapper.setup :default, 'sqlite3::memory:'
end