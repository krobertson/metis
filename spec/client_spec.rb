require 'spec_helper'

describe Metis::Client do
  before do
    @socket = mock
    @context = Metis::Context.new File.dirname(__FILE__)+"/resources/sample/metis.rb"
    @context.load
    @client = Metis::Client.new @socket, @context
  end

  describe '.process' do
    it 'should process a valid packet, run the command, and send a response' do
      query = Metis::NrpePacket.new
      query.packet_type = :query
      query.buffer = "simple"

      Metis::NrpePacket.should_receive(:read).and_return(query)

      @socket.should_receive(:write).with(/we're good/)
      @socket.should_receive :close

      @client.process.should == true
    end

    it 'should not accept command arguments' do
      query = Metis::NrpePacket.new
      query.packet_type = :query
      query.buffer = "simple!argument"

      Metis::NrpePacket.should_receive(:read).and_return(query)

      @socket.should_receive(:write).with(/\002Arguments not allowed/)
      @socket.should_receive :close

      @client.process.should be_nil
    end

    it 'should return a message when the command doesn\'t exist' do
      query = Metis::NrpePacket.new
      query.packet_type = :query
      query.buffer = "nonexistant"

      Metis::NrpePacket.should_receive(:read).and_return(query)

      @socket.should_receive(:write).with(/\001Command nonexistant not found/)
      @socket.should_receive :close

      @client.process.should be_nil
    end

    it 'should handle packets that throw an invalid CRC error' do
      Metis::NrpePacket.should_receive(:read).and_raise("Invalid CRC32")

      @socket.should_receive(:write).with(/\002Error encountered while processing: Invalid CRC32/)
      @socket.should_receive(:close)

      @client.process.should == true
    end
  end
end
