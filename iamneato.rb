require 'bundler/setup'
require 'sinatra/base'

class Iamneato < Sinatra::Base

  get '/' do
    haml :index
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

