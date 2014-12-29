expect = require('chai').expect
fs = require('fs')
converter = require('../src/object_converter')

describe 'converting a single object', ->
  loadFixture = (name) ->
    JSON.parse(fs.readFileSync("./test/fixtures/notifications/#{name}.json"))

  describe 'a commentCard event', ->
    it 'builds a valid activity', ->
      commentCard = loadFixture('commentCard')
      activity = converter.notificationToActivity(commentCard)
      expect(activity).to.deep.eq({
        "verb": {
          "id": "trello.commentCard",
          "displayName": "comment on card"
        },
        "published": "2014-12-24T04:42:03.678Z",
        "language": "en",
        "actor": {
          "objectType": "person",
          "id": "trello.bilbobaggins",
          "displayName": "Bilbo Baggins",
          "url": "https://trello.com/bilbobaggins",
          "image": {
            "url": "https://trello-avatars.s3.amazonaws.com/b44ca6979b87431323664ee46d75c7/170.png",
            "mediaType": "image/jpeg",
            "width": 170,
            "height": 170
          }
        },
        "object" : {
          "objectType": "trello.card",
          "id": "trello.5496646974598104ca4fc6"
          "url": "http://trello.com/c/GJGTBRY0",
          "displayName": "The name of the card"
        },
        "target" : {
          "objectType": "trello.board",
          "id": "trello.52b2536953920ef20020bf",
          "displayName": "My Board",
          "url": "http://trello.com/b/FO98bRzg"
        }
     })

    it 'builds doesnt build an image if there is no avatar hash', ->
      commentCard = loadFixture('no_avatar')
      activity = converter.notificationToActivity(commentCard)
      expect(activity.actor).to.deep.eq({
        "objectType": "person",
        "id": "trello.bilbobaggins",
        "displayName": "Bilbo Baggins",
        "url": "https://trello.com/bilbobaggins",
      })      
