# Flowthings Gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'flowthings'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install flowthings
```

## Usage

###  `Flowthings::Client.new(options)`

returns a new instance of the client. The client needs your account name and account token in order to connect to the server. You can pass these in the options hash:

```ruby
{account_name: @account_name, account_token: @account_token}
```

Or, they are accessible through public functions on the client. You can access the other options in the same way.

The client is composed of services for querying the different domains of the platfrom.

-   `flow`
-   `drop`
-   `track`
-   `group`
-   `identity`
-   `token`
-   `share`
-   `api_importer`
-   `mqtt_connection`

### Service Methods

#### `service.create(data, params?)`

```ruby
client.flow.create path: '/foo/bar'
```

#### `service.read(id, params?)`

```ruby
client.flow.read '<flow_id>'
```

#### `service.update(id, data, params?)`

```ruby
client.flow.update '<flow_id>', path: '/foo/baz'
```

#### `service.member_update(id, data, params?)`

```ruby
client.flow.member_update '<flow_id>', path: '/foo/baz'
```

#### `service.destroy(id, params?)`

```ruby
client.flow.destroy '<flow_id>'
```

#### `service.find(params?)`

```ruby
client.flow.find filter: "path =~ /\\/greg\\/test\\/ruby/"
```

#### `service.find_many(filters, params?)`

```ruby
client.drop.find_many '<flow_id>': '<filter>', '<flow_id2>': '<filter>'
```

#### `service.simulate(data, params?)`

```ruby
track = {
  "drop": {
    "elems": {
      "a": 1
    }
  },
  "js": "function (input_drop) {
        var a = input_drop.elems.a.value;
        input_drop.elems.b = a  * 3;
        return input_drop;
      }"
}

client.track.simulate track
```
#### `service.aggregate(data, params?)`

```ruby
client.drop("<flow_id>").aggregate "output": ["$count"]
```

**Note:** Not all services support all the methods. `share`s and `token`s are
immutable, and so do not support `update`.
`identity` only supports `read` and `find`.
Only `track` supports `simulate`, and only `drop` supports `find_many`

The methods return a hash of the platform's response. For instance, `flow.read('flow_id')` will return:

```ruby
{
  "id": "<flow_id>",
  "capacity": "<capacity>",
  "creationDate": "<creation_date>",
  "creatorId": "<creator_id>",
  "lastEditDate": "<last_edit_date>",
  "path": "<flow_path>"
}
```

### Example

For a bunch of examples, look in the platform objects specs.

```ruby
api = Flowthings::Client.new account_name: <account_name>, account_token: <account_token>

api.flow.read "f55171ff90cf2ece6103ef410"

# => {"id": "f55171ff90cf2ece6103ef410",
#            "capacity": 1000,
#            "creationDate": 1427578873318,
#            "creatorId": "i54af263c0cf25b8ea459c204",
#            "path": "/greg/test/ruby-drop"}

```

## Compatability

Flowthings has been tested in:

MRI 1.9.3, 2.0.0, 2.1.5, 2.2.0, 2.2.1, 2.2.2

We will not support MRI prior to 1.9.3.

Rubinius 2.4.1, 2.5.2

Jruby 1.7.9, 1.7.19, 9000 (on Java 8)
