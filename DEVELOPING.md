## Developing

The library is broken into a pretty standard API wrapper. It has a main object, under which all others are nested. It frequently uses mixins to add functionality to various classes. All in all it's pretty nicely and neatly put together.

### Testing
You must use a .env file, as the tests connect to the live platform. They will create and delete flows, drops and tracks from the account you put in there.

It will use the flow `/account_name/ruby-client-test`.

The client will create and delete from that path. You shouldn't have that flow there before starting, it will create it for you. You will also need an internet connection.
