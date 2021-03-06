require 'spec_helper'

describe Foto::Config do
  let(:config)   { Foto::Config }
  let(:defaults) { Foto::Config::Defaults }

  before do
    config.reset!
  end

  describe '.api_key' do
    it 'has a default' do
      config.api_key.should eql(defaults::API_KEY)
    end
  end

  describe '.base_uri' do
    it 'has a default' do
      config.base_uri.should eql(defaults::BASE_URI)
    end
  end

  describe '.reset!' do
    it 'resets the configuration to their default values' do
      config.api_key = 'somethingelse'
      config.api_key.should eql('somethingelse')
      config.base_uri = 'http://other.com'
      config.base_uri.should eql('http://other.com')
      config.reset!
      config.api_key.should eql(defaults::API_KEY)
      config.base_uri.should eql(defaults::BASE_URI)
    end
  end

  describe '.options' do
    it 'returns a hash of current options' do
      config.options.keys.should =~ Foto::Config::VALID_OPTIONS
    end
  end
end

describe Foto do
  describe '.configure' do
    Foto::Config::VALID_OPTIONS.each do |option|
      it "#{option} should be configurable" do
        Foto.configure do |configuration|
          configuration.send("#{option}=", option)
          configuration.send(option).should eql(option)
        end
      end
    end
  end
end
