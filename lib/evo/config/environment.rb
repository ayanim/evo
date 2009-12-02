
configure do |app|
  require 'moneta/memory'
  set :port, 3000
  set :theme, :chrome
  set :admin_email, nil
  set :admin_password, nil
  set :haml, :escape_html => true
  set :store, Moneta::Memory.new
  set :run, lambda { File.basename($0) != 'evo' and not File.basename($0).ends_with?('_worker.rb') }
  enable :sessions
  enable :methodoverride
  disable :static
  DataMapper.setup :default, "sqlite3:///#{File.expand_path(app.root)}/databases/evo.#{app.environment}.db"
end

configure :test do
  set :admin_email, 'admin@example.com'
  set :admin_password, 'foobar'
  enable :raise_errors
  disable :run
  disable :logging
  DataMapper.setup :default, 'sqlite3::memory:'
end