require 'spec_helper'

describe 'configuration' do

  Flowthings::Configuration::VALID_CONFIG_KEYS.each do |key|
    describe ".#{key}" do
      it 'should return the default value' do
        expect(Flowthings.send(key)).to eq(Flowthings::Configuration.const_get("DEFAULT_#{key.upcase}"))
      end
    end
  end

  after do
    Flowthings.reset
  end

  describe '.configure' do
    Flowthings::Configuration::VALID_CONFIG_KEYS.each do |key|
      it "should set the #{key}" do
        Flowthings.configure do |config|
          config.send("#{key}=", key)
          expect(Flowthings.send(key)).to eq(key)
        end
      end
    end
  end

end
