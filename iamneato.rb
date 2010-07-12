# add lib dir to load path
$:.unshift File.join(File.expand_path(File.dirname(__FILE__)), 'lib')

require 'bundler_helper'
require 'sinatra/base'
require 'time'
require 'article_getter'
require 'helpers'
require 'haml_overrides'

class Iamneato < Sinatra::Base

  configure do
    set :app_file, __FILE__
    set :logging, Proc.new { !test? }
    set :run, Proc.new { !test? }
    set :dump_errors, true
    set :haml, {:format => :html5 }
  end

  helpers do
    include Helpers
  end

  before do
    @getter = ArticleGetter.new(File.join(settings.root, "articles"))
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
    @illustrations = illustrations
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
end

at_exit { Iamneato.run! if $!.nil? && Iamneato.run? }

