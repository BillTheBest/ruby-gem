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
