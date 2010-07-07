begin
  # Require the pre-resolved locked set of gems.
  require ::File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  # Fallback on doing the resolve at runtime.
  require 'rubygems'
  require 'bundler'
  Bundler.setup
end

$:.unshift File.expand_path(File.dirname(__FILE__) + '/lib/')

require 'sinatra'
require 'haml'
require 'time'
require 'article_getter'
require 'helpers'
require 'haml_overrides'

set :haml, {:format => :html5 }

before do
  @getter = ArticleGetter.new(File.join(Sinatra::Application.root, "articles"))
end

get '/' do
  @articles = @getter.all.sort[0..4]
  haml :home
end

get '/:year/:month/:day/:id' do
  @article = @getter.find_by_id(params[:id]) || raise(Sinatra::NotFound)
  @title = @article.title
  haml :article
end

get '/doodles' do
  @title = 'Doodles'
  haml :doodles
end

get '/archive' do
  @archives = @getter.archives
  @total = @getter.all.length
  @title = 'Archive'
  haml :archive
end

get '/about' do
  @title = 'About'
  haml :about
end

get '/articles.atom' do
  @articles = @getter.all.sort
  content_type 'application/atom+xml'
  haml :feed, :layout => false
end

get '/:stylesheet.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :"stylesheets/#{params[:stylesheet]}", :style => :compact
end

not_found do
  @title = '404 - Page Not Found'
  haml :'404', :layout => false
end
