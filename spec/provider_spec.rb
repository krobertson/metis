require 'spec_helper'

describe Metis::Provider do
  before do
    @context = Metis::Context.new File.dirname(__FILE__)+"/resources/sample/metis.rb"
    @context.load
  end

  describe '.run' do
    it 'should return a result' do
      provider = Metis::Provider.new @context.definitions[:simple], @context
      provider.run

      provider.response_code.should == Metis::STATUS_OK
      provider.response_message.should == "we're good"
    end

    it 'should capture exceptions' do
      provider = Metis::Provider.new @context.definitions[:error], @context

      lambda {
        provider.run
      }.should_not raise_error

      provider.response_code.should == Metis::STATUS_CRITICAL
      provider.response_message.should == "Exception raised: booboo"
    end

    it 'should handle a return of a string as the message' do
      provider = Metis::Provider.new @context.definitions[:just_string], @context
      provider.run

      provider.response_code.should == Metis::STATUS_OK
      provider.response_message.should == "hello"
    end

    it 'should handle requiring gems that aren\'t there' do
      provider = Metis::Provider.new @context.definitions[:bad_gem], @context

      lambda {
        provider.run
      }.should_not raise_error

      provider.response_code.should == Metis::STATUS_CRITICAL
      provider.response_message.should == "Failed to load gem: uhhohh"
    end

    it 'should enforce a timeout and return an error when exceeded' do
      provider = Metis::Provider.new @context.definitions[:sleep], @context

     lambda {
        provider.run
      }.should_not raise_error

      provider.response_code.should == Metis::STATUS_CRITICAL
      provider.response_message.should == "The check timed out"
   end
  end

  describe 'state' do
    it 'should set warning state' do
      provider = Metis::Provider.new @context.definitions[:warning], @context
      provider.run

      provider.response_code.should == Metis::STATUS_WARNING
      provider.response_message.should == "careful there"
    end

    it 'should set critical state' do
      provider = Metis::Provider.new @context.definitions[:critical], @context
      provider.run

      provider.response_code.should == Metis::STATUS_CRITICAL
      provider.response_message.should == "uhh ohh"
    end

    it 'should handle precedence when there are multiple state assertions' do
      provider = Metis::Provider.new @context.definitions[:precedence], @context
      provider.run

      provider.response_code.should == Metis::STATUS_CRITICAL
      provider.response_message.should == "crit"
    end
  end
end
