# trello-notification-to-activitystream2

A node.js transformation stream that converts trello notifications to activitystream2 activities

## Installation

Install via npm:

```bash
$ npm install trello-notification-to-activitystream2
```
## Usage

This stream transform expect an incoming object stream of trello notifications, as returned by a url such as:

https://api.trello.com/1/members/USERNAME/notifications?key=KEY&token=TOKEN

If you want to pull these from Trello, you might want to check out my trello-notification-stream package.

This package uses through2 to convert each of the objects in the stream to activity objects of the format specified
buy the ActivityStreams 2.0 proposed standard.

https://tools.ietf.org/html/draft-snell-activitystreams-09

## Examples

```coffeescript
notifications = require('trello-notification-stream')
stdout = require('stdout')
options = {
  key: 'YOUR_KEY',
  token: 'YOUR_TOKEN',
  username: 'YOUR_TRELLO_USERNAME'  
}
converter = require('./index.js')
notifications(options).pipe(converter()).pipe(stdout())
```

## Error Handling

As the trello API documentation does not provide an exhaustive list of all possible notification types, if
an unknown notification type is handled, this stream will emit an error object that looks like this:

```coffeescript
{
  error: "unknown_notification_type",
  originalObject: {/* original object details here*/}
}
```

You should check for the error key on returned objects to see if they are error objects. If you find one,
take a look at the originalObject and pop it on a github issue here for me and I'll add it to the mapper (or
do it yourself and make a pull request)
