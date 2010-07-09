require 'rubygems'
require 'spec'
require 'spec/autorun'
require 'spec/interop/test'
require 'rack/test'

# absolute path to lib folder
lib_dir = File.join(File.expand_path(File.dirname(__FILE__)), '../lib')

# insert lib folder into load_paths if it's not already
$:.unshift lib_dir unless $:.include?(lib_dir)

Spec::Runner.configure do |config|

  def app
      Main.new
      Main.set :environment, :test
      Main.set :run, false
      Main.set :raise_errors, true
      Main.set :logging, false
  end

  config.include(Rack::Test::Methods)
end

