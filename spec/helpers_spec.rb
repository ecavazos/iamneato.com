require File.expand_path('../spec_helper', __FILE__)
require 'helpers'

class Host
  include Helpers
end

describe 'Helpers' do
  before(:each) do
    @host = Host.new
  end

  describe 'illustrations' do
    it 'should not have "." in the array' do
      @host.illustrations().include?('.').should be_false
    end

    it 'should not have ".." in the array' do
      @host.illustrations().include?('.').should be_false
    end

    it 'should fetch an array of illustrations' do
      f = @host.illustrations().select {|x| x == 'metal_hand.jpg'}
      f.first.should == 'metal_hand.jpg'
    end
  end

end
