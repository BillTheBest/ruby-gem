require 'spec_helper'
require 'active_support/inflector'

describe Flowthings::Client do
  services = ["api_task", "drop", "flow", "group", "identity", "mqtt", "share", "token", "track"]

  describe 'interfaces' do
    before do
      @api = Flowthings::Client.new
    end

    services.each do |service|
      service_class = "flowthings/" + service
      service_class = service_class.camelize.constantize

      describe ".#{service}" do
        it "the method should exist" do
          expect(@api.respond_to? "#{service}").to be true
        end

        it "the method should construct the proper class" do
          if service == 'drop'
            initialized_service = @api.send("#{service}", "d")
            expect(initialized_service.class).to eq(service_class)
          else
            initialized_service = @api.send("#{service}")
            expect(initialized_service.class).to eq(service_class)
          end
        end

        if service == 'drop'
          it "should throw an error if it is called without an argument" do
            expect { @api.send("#{service}") }.to raise_error
          end

          it "should raise an argument error" do
            expect { @api.send("#{service}") }.to raise_error(ArgumentError)
          end

          it "should not throw an error if it is called with an argument" do
            expect { @api.send("#{service}", "d") }.not_to raise_error
          end
        end

      end # describe block

    end # services loop

  end #interfaces

end
