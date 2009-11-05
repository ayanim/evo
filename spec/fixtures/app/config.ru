
$:.unshift File.dirname(__FILE__) 
require 'rubygems'
require 'evo'
require 'config/environment'

run Sinatra::Application
