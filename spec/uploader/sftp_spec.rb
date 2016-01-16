require 'spec_helper'

describe Uploader::SFTP do
  it 'has a version number' do
    expect(Uploader::SFTP::VERSION).not_to be nil
  end

  context 'connection' do
    before(:each) do
      @hostname = 'localhost'
      @host     = Uploader::SFTP::Host.new(:hostname => @hostname, :user => 'user', :password => 'password')
      @ftp      = Uploader::SFTP.new(:host => @host)
    end
    it '#site' do
      expect(@ftp.site).to eq('localhost:22')
    end
  end
end
