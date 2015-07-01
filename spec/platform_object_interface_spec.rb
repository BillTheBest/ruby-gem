require 'spec_helper'

describe Flowthings::PlatformObjectInterface do
  describe "platform object" do
    before do
      @connection = {}
    end
    it "should raise an error if you try to initialize it" do
      expect { Flowthings::PlatformObjectInterface.new @connection }.to raise_error(Flowthings::Error::ObjectError, "Use the actual platform objects")
    end
  end
end
