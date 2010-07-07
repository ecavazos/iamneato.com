require "rubygems"
require "spec"
require "spec/autorun"
require "spec/interop/test"
require "rack/test"

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

