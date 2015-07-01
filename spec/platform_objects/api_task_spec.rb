require 'spec_helper'

describe Flowthings::ApiTask do

  before do
    @account_name = ENV["FT_ACCOUNT_NAME"]
    @account_token = ENV["FT_ACCOUNT_TOKEN"]

    @api = Flowthings::Client.new({account_name: @account_name,
                                   account_token: @account_token})
  end

  describe ".create, .read, .update, .destroy" do

    before(:example) do
      @path = "/" + @account_name + "/ruby-client-test"
      @flow = @api.flow.create({"path" => @path,
                                "description" => "description"})

      @flowId = @flow["id"]

      @api_task_task = {
        "destination" => @path,
        "periodicity" => 120000,
        "js" => "new Task({
          request: {uri: 'http://api.example.com/data.json', method: 'GET'},
          callback: function(responseText) {
          var json = JSON.parse(responseText);
            return json['items'].map(function(item) {
              return {
                elems: {
                  title : {type: 'string', value: item.title},
                  source_uri : {type: 'uri', value: item.uri}
                }
              }
            });"
      }

      @api_task_task_updated = {
        "destination" => @path,
        "periodicity" => 120000,
        "js" => "new Task({
          request: {uri: 'http://api.example.com/data.json', method: 'GET'},
          callback: function(responseText) {
          var json = JSON.parse(responseText);
            return json['items'].map(function(item) {
              return {
                elems: {
                  title : {type: 'string', value: item.title},
                  source_uri : {type: 'uri', value: item.uri}
                }
              }
            });",
        "displayName" => "testtesttest"
      }

    end

    after(:example) do
      @api.flow.delete(@flowId)
    end


    it "should do all of these operations correctly" do

      api_task_response = @api.api_task.create(@api_task_task)

      expect(api_task_response.empty?).not_to be true

      expect(api_task_response["destination"]).to eq(@path)
      expect(api_task_response["periodicity"]).to eq(@api_task_task["periodicity"])
      expect(api_task_response["js"]).to eq(@api_task_task["js"])

      read_response = @api.api_task.read(api_task_response["id"])

      expect(read_response["id"]).to eq(api_task_response["id"])

      update_response = @api.api_task.update(api_task_response["id"],
                                                  @api_task_task_updated)


      expect(update_response["displayName"]).to eq(@api_task_task_updated["displayName"])

      delete_response = @api.api_task.delete(api_task_response["id"])

      expect(delete_response.empty?).to be true
    end

  end


end
