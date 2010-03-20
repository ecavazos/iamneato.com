require "rubygems"
require "spec"
require "spec/autorun"
require "spec/interop/test"
require "iamneato"
require "sinatra"
require "rack/test"
 
# set test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false
