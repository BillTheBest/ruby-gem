require 'spec_helper'
require 'active_support/inflector'

platform_objects = [Flowthings::ApiTask, Flowthings::Drop, Flowthings::Flow, Flowthings::Group, Flowthings::Identity, Flowthings::Mqtt, Flowthings::Share, Flowthings::Token, Flowthings::Track]
crud_methods = ["create", "read", "update", "destroy"]


platform_objects.each do |platform_object|

  describe platform_object do

    before do
      @options = {}
      @flowId = "f123456"
      @connection = {}
    end

    describe "initialization" do
      it "should error out without any arguments" do
        expect { platform_object.new }.to raise_error(ArgumentError)
      end

      unless platform_object == Flowthings::Drop
        it "should take a connection argument and an options argument" do
          expect { platform_object.new @connection, @options }.not_to raise_error
        end
        it "the options argument should be optional" do
          expect { platform_object.new @connection }.not_to raise_error
        end
      else
        it "should take an options argument, a flowId and a connection" do
          expect { platform_object.new @flowId, @connection, @options }.not_to raise_error
        end

        it "should error out with only one argument" do
          expect { platform_object.new @flowId }.to raise_error(ArgumentError)
        end

        it "should have an optional options argument" do
          expect { platform_object.new @flowId, @connection }.not_to raise_error
        end
      end

    end #init

    describe "crud" do
      before do
        unless platform_object == Flowthings::Drop
          @initialized_object = platform_object.new @options
        else
          @initialized_object = platform_object.new @flowId, @options
        end
      end

      crud_methods.each do |method|
        describe ".#{method}" do
          unless method == "update"&& ( platform_object == Flowthings::Share || platform_object == Flowthings::Token )
            it "should respond to the method" do
              expect(@initialized_object.respond_to? "#{method}").to be true
            end
          else
            it "should not respond to the method" do
              expect(@initialized_object.respond_to? "#{method}").to be false
            end
          end
        end

      end

    end
  end

end
