require 'spec_helper'

describe Metis::Context do
  context "configuration" do
    it 'should load the specified configuration file' do
      config_file = File.dirname(__FILE__)+"/resources/sample/metis.rb"
      IO.should_receive(:read).with(config_file).and_return("")
      Metis::Context.new(config_file).should_not be_nil
    end
  end

  describe '.load' do
    before do
      @context = Metis::Context.new
      @working_dir = File.dirname(__FILE__)+"/resources/sample"
      @context.configuration.working_directory @working_dir
    end

    it 'should chdir into the working directory' do
      Dir.should_receive(:chdir).with(@working_dir)
      @context.load.should == true
    end

    it 'should load the given checks' do
      @context.load

      @context.definitions[:simple].should_not be_nil
      @context.definitions[:simple].should be_kind_of Metis::CheckDefinition
    end

    it 'handle duplicates and have the 2nd take precedence' do
      @context.load

      @context.definitions[:duplicate].should_not be_nil
      @context.definitions[:duplicate].should be_kind_of Metis::CheckDefinition
      @context.definitions[:duplicate].params[:name].should == 'Jane'
    end

    it 'should load extra configuration' do
      @context.load

      @context.definitions[:simple_arg].params[:name].should == 'Jim'
    end
  end
end
