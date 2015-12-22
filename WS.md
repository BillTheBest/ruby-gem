# Outline of WS API

You'll get a run command and everything will just be wrapped in that.

``` ruby
    flowthings.ws.run do |ws|
        ws.drop(flowId).create()
        ws.flow.subscribe flowId do |drop|
            #listener
        end
    end
```

We'll create an entirely internal system of listeners that the user will have access to, if they want, but that they do not have to use.

It will also use its own EM object, so that it can attach these listeners without interfering with the listeners on the object in WS.

It'll just pass them back and forth in exactly the same way as we do in the node client.
