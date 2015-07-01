require 'spec_helper'

describe Flowthings::Client do
  before do
    @keys = Flowthings::Configuration::VALID_CONFIG_KEYS
  end

  describe 'configuration' do

    describe 'with module configuration' do
      before do
        Flowthings.configure do |config|
          @keys.each do |key|
            config.send("#{key}=", key)
          end
        end
      end

      after do
        Flowthings.reset
      end

      it 'should inherit module configuration' do
        api = Flowthings::Client.new

        @keys.each do |key|
          expect(api.send(key)).to eq(key)
        end
      end
    end

    describe 'with class configuration' do
      before do
        @config = {
          account_name: 'aa',
          account_token: 'bb',
          endpoint: 'dd',
          user_agent: 'ee',
          secure: 'ff',
          platform_version: 'gg',
        }
      end

      it 'should override module configuration' do
        api = Flowthings::Client.new(@config)

        @keys.each do |key|
          expect(api.send(key)).to eq(@config[key])
        end
      end

      it 'should override module configuration after' do
        api = Flowthings::Client.new

        @config.each do |key, value|
          api.send("#{key}=", value)
        end

        @keys.each do |key|
          expect(api.send("#{key}")).to eq(@config[key])
        end
      end

    end
  end

end
