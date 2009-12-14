
$:.unshift 'lib'
require 'rubygems'
require 'evo'
require 'rake'
require 'echoe'

Echoe.new 'evo', Evo::VERSION do |p|
  p.author = "TJ Holowaychuk"
  p.email = "tj@vision-media.ca"
  p.summary = "Evolution Content Management System"
  p.url = "http://github.com/visionmedia/evo"
  p.runtime_dependencies = []
  p.runtime_dependencies << 'haml'
  p.runtime_dependencies << 'moneta'
  p.runtime_dependencies << 'daemon-spawn'
  p.runtime_dependencies << 'tilt'
  p.runtime_dependencies << 'rext >=0.6.1'
  p.runtime_dependencies << 'formz >=0.1.0'
  p.runtime_dependencies << 'sinatra >=0.9.4'
  p.runtime_dependencies << 'dm-core >=0.10.2'
  p.runtime_dependencies << 'dm-migrations >=0.10.2'
  p.runtime_dependencies << 'dm-timestamps >=0.10.2'
  p.runtime_dependencies << 'dm-validations >=0.10.2'
  p.runtime_dependencies << 'dm-serializer >=0.10.2'
  p.runtime_dependencies << 'dm-types >=0.10.2'
  p.runtime_dependencies << 'dm-pager'
  p.development_dependencies << 'webrat'
end

task :gemspec => [:build_gemspec]