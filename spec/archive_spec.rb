require File.expand_path('../spec_helper', __FILE__)
require 'archive'

describe 'Archive' do

  it 'should initialize month_year' do
    a = Archive.new 'August 2009'
    a.month_year.should == 'August 2009'
  end

  it 'should initialize articles to an empty array' do
    a = Archive.new 'August 2009'
    a.articles.length.should == 0
  end

  it 'should initialize articles with article' do
    a = Archive.new 'August 2009', 'fake article array'
    a.articles.length.should == 1
  end

end
