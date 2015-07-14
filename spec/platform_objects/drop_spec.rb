require 'spec_helper'

describe Flowthings::Drop do
  before do
    @account_name = ENV["FT_ACCOUNT_NAME"]
    @account_token = ENV["FT_ACCOUNT_TOKEN"]

    @api = Flowthings::Client.new account_name: @account_name, account_token: @account_token

    # @flow = @api.flow.create({"path" => "/greg/test/ruby"})
  end

  # after do
  #   # @flow = @api.flow.create({"path" => "/greg/test/ruby"})
  # end


  describe ".get" do
    it "should get the proper information from the platform" do
      api = Flowthings::Client.new({account_name: "greg",
                                     account_token: "3PxWefluMlQeMtFpy9WPGkeijU5G"})

      result = {
        "id" => "d551720070cf25d405fb1e495",
        "flowId" => "f55171ff90cf2ece6103ef410",
        "creationDate" => 1427578887233,
        "path" => "/greg/test/ruby-drop",
        "version" => 0,
        "elems" => {
          "drop" => {
            "type" => "string",
            "value" => "adsf"
          }
        }
      }

      drop = api.drop("f55171ff90cf2ece6103ef410").read("d551720070cf25d405fb1e495")

      expect(drop).to eq(result)
    end
  end

  describe ".create, .update, .destroy" do

    before(:example) do
      @path = "/" + @account_name + "/ruby-client-test"
      @flow = @api.flow.create "path" => @path, "description" => "description"

      @flowId = @flow["id"]

      @drop = {"elems" => {
                 "elem_name" => {
                   "type" => "string",
                   "value" => "elem_value"
                 }
               }
              }

      @update_drop = {"elems" => {
                        "elem_name" => {
                          "type" => "string",
                          "value" => "elem_value"
                        },
                        "second_elem" => {
                          "type" => "string",
                          "value" => "elem_value"
                        }
                      }
                     }
    end

    after(:example) do
      @api.flow.delete @flowId
    end

    it "should create, update and then delete a drop on the platform" do
      create_response = @api.drop(@flowId).create @drop
      dropId = create_response["id"]

      update_response = @api.drop(@flowId).update dropId, @update_drop

      destroy_response = @api.drop(@flowId).destroy dropId

      expect(create_response.empty?).not_to be true
      expect(create_response["flowId"]).to eq(@flowId)
      expect(create_response["elems"]).to eq(@drop["elems"])

      expect(update_response.empty?).not_to be true
      expect(update_response["flowId"]).to eq(@flowId)
      expect(update_response["id"]).to eq(dropId)
      expect(update_response["elems"]).to eq(@update_drop["elems"])

      expect(destroy_response.empty?).to be true
    end

  end

  describe ".aggregate" do
    before(:example) do
      @path = "/" + @account_name + "/ruby-client-test"
      @flow = @api.flow.create({"path" => @path,
                                "description" => "description"})

      @flowId = @flow["id"]

      @drop = {"elems" => {
                 "elem_name" => {
                   "type" => "string",
                   "value" => "elem_value"
                 }
               }
              }

      @api.drop(@flowId).create(@drop)

      @aggregation = {
        "filter" => "EXISTS elem_name",
        "output" => ["$count"]
      }
    end

    after(:example) do
      @api.flow.delete(@flowId)
    end

    it "should aggregate properly" do
      aggregate_response = @api.drop(@flowId).aggregate(@aggregation)

      expect(aggregate_response.class).to be Array
      expect(aggregate_response[0]["$count"]).to eq(1)
    end

  end


  describe "error" do

    before(:example) do
      path = "/" + @account_name + "/ruby-client-test"

      @flow = @api.flow.create({"path" => path,
                                "description" => "description"})

      @flowId = @flow["id"]
      @api.flow.destroy(@flowId)

      @drop = {"elems" => {
                 "elem_name" => {
                   "type" => "string",
                   "value" => "elem_value"
                 }
               }
              }
    end

    it "should error when appropriate" do
      expect {
        @api.drop(@flowId).create(@drop)
      }.to raise_error
    end

    it "should be able to rescue from an error" do
      expect {
        begin
          @api.drop(@flowId).create(@drop)
        rescue Flowthings::Error::BadRequest => e
          error = e
        end

      }.not_to raise_error
    end

  end

end
