
$:.unshift File.dirname(__FILE__) 
$:.unshift File.dirname(__FILE__) + '/../../lib'
require 'rubygems'
require 'evo'
require 'config/environment'

run Sinatra::Application
