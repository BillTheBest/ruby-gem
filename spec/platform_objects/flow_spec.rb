require 'spec_helper'

describe Flowthings::Flow do
  before do
    @flowid = "f55171ff90cf2ece6103ef410"

    @account_name = ENV["FT_ACCOUNT_NAME"]
    @account_token = ENV["FT_ACCOUNT_TOKEN"]
    @api = Flowthings::Client.new({account_name: @account_name,
                                   account_token: @account_token})
  end

  describe ".read" do
    it "should get the proper information from the platform" do
      api = Flowthings::Client.new({account_name: 'greg',
                                     account_token: "p2lAhiLuQeqWN0EMeClmTAYPjgPy"})

      response = {"id" => "f55171ff90cf2ece6103ef410",
                  "capacity" => 1000,
                  "creationDate" => 1427578873318,
                  "creatorId" => "i54af263c0cf25b8ea459c204",
                  "path" => "/greg/test/ruby-drop"}


      expect(api.flow.read(@flowid)).to eq(response)
    end
  end


  describe ".create, .update, .delete" do
    it "should create, update and then delete a flow properly" do
      response = {}

      path = "/" + @account_name + "/ruby-client-test"

      expect{
        response = @api.flow.create({"path" => path,
                                     "description" => "description",
                                     "filter" => "EXISTS title"})
      }.not_to raise_error

      expect(response.empty?).not_to be true
      expect(response["path"]).to eq(path)
      expect(response["description"]).to eq("description")
      expect(response["filter"]).to eq("EXISTS title")

      updated_response = @api.flow.update(response["id"], {"path" => path,
                                                           "description" => "description",
                                                           "filter" => ""})
      @id = response["id"]

      expect(updated_response["id"]).to eq(response["id"])
      expect(updated_response["description"]).to eq("description")
      expect(updated_response["path"]).to eq(path)

      expect(updated_response["filter"].empty?).to be true

      expect(@api.flow.destroy(response["id"]).empty?).to be true
    end
  end

  describe ".find" do
    before do
      path = "/" + @account_name + "/ruby-client-test"
      @flow = @api.flow.create({"path" => path,
                                "description" => "description",
                                "filter" => "EXISTS title"})
    end

    after do
      @api.flow.destroy(@flow["id"])
    end

    it "should find the correct flow" do
      path_regex = "/\\/" + @account_name + "\\/ruby-client-test/"

      flow = @api.flow.find(filter: "path =~ " + path_regex)
      expect(flow[0] == @flow)
    end

  end

end
