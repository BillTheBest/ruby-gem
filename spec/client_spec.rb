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

      end # describe block

    end # services loop

  end #interfaces

end
