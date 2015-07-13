require "spec_helper"

describe Flowthings::Track do
  before(:example) do
    @account_name = ENV["FT_ACCOUNT_NAME"]
    @account_token = ENV["FT_ACCOUNT_TOKEN"]

    @api = Flowthings::Client.new({
                                    account_name: @account_name,
                                    account_token: @account_token
                                  })
  end

  describe ".create" do
    before(:example) do
      @path = "/" + @account_name + "/ruby-client-test"
      @destination_path = "/" + @account_name + "/ruby-client-test/destination"

      @flow = @api.flow.create "path" => @path, "description" => "description"
      @destination_flow = @api.flow.create "path" => @destination_path, "description" => "description"

      @flowId = @flow["id"]
      @flowId_destination = @destination_flow["id"]

      @track = {
        "source" => @path,
        "destination" => @destination_path,
        "js" => "function (input_drop) {
              var a = input_drop.elems.a.value;
              input_drop.elems.b = a  * 3;
              return input_drop;
            }"
      }
    end

    it "should create a track properly" do
      @track_response = @api.track.create @track

      expect(@track_response["js"]).not_to be_empty
      expect(@track_response["source"]).to eq @path
      expect(@track_response["destination"]).to eq @destination_path
    end

    after(:example) do
      @api.flow.delete @flowId
    end

  end

  describe ".simulate" do
    it "should simulate track output" do

      simulated_track = {
        "drop" => {
          "elems" => {
            "a" => 1
          }
        },
        "js" => "function (input_drop) {
              var a = input_drop.elems.a.value;
              input_drop.elems.b = a  * 3;
              return input_drop;
            }"
      }


      track_response = @api.track.simulate(simulated_track)

      expect(track_response.empty?).not_to be true

      drops = track_response["drops"]
      log = track_response["log"]
      errs = track_response["errors"]

      expect(errs.empty?).to be true
      expect(drops.empty?).not_to be true
      expect(log.empty?).not_to be true

    end
  end

end
