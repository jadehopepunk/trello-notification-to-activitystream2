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
          "displayName": "commented on card"
        },
        "published": "2014-12-24T04:42:03.678Z",
        "language": "en",
        "actor": {
          "objectType": "person",
          "id": "trello.bilbobaggins",
          "displayName": "Bilbo Baggins",
          "url": "http://trello.com/bilbobaggins",
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
        },
        "result": {
          "text": "This is the comment test that was added."
        }
     })

    it 'builds doesnt build an image if there is no avatar hash', ->
      commentCard = loadFixture('no_avatar')
      activity = converter.notificationToActivity(commentCard)
      expect(activity.actor).to.deep.eq({
        "objectType": "person",
        "id": "trello.bilbobaggins",
        "displayName": "Bilbo Baggins",
        "url": "http://trello.com/bilbobaggins",
      })      

  describe 'a removedFromCard event', ->
    it 'builds a valid activity', ->
      commentCard = loadFixture('removedFromCard')
      activity = converter.notificationToActivity(commentCard)
      expect(activity).to.deep.eq({
        "verb": {
          "id": "trello.removedFromCard",
          "displayName": "removed from card"
        },
        "published": "2014-12-29T05:14:55.573Z",
        "language": "en",
        "actor": {
          "objectType": "person",
          "id": "trello.samgamgee",
          "displayName": "Samwise Gamgee",
          "url": "http://trello.com/samgamgee",
          "image": {
            "url": "https://trello-avatars.s3.amazonaws.com/04efae26fd242a912663e3630551b6/170.png",
            "mediaType": "image/jpeg",
            "width": 170,
            "height": 170
          }
        },
        "object" : {
          "objectType": "trello.card",
          "id": "trello.546a650bc8837b1d5588a188"
          "url": "http://trello.com/c/BcoRhZxG",
          "displayName": "[2] Import all non-listing data from upper hutt onto production"
        },
        "target" : {
          "objectType": "trello.board",
          "id": "trello.53fc171865067982a4de41b2",
          "displayName": "PropertyNZ Sprint",
          "url": "http://trello.com/b/Az1wabpW"
        }
     })

  describe 'an addedToCard event', ->
    it 'builds a valid activity', ->
      commentCard = loadFixture('addedToCard')
      activity = converter.notificationToActivity(commentCard)
      expect(activity).to.deep.eq({
        "verb": {
          "id": "trello.addedToCard",
          "displayName": "added to card"
        },
        "published": "2014-12-29T05:14:55.573Z",
        "language": "en",
        "actor": {
          "objectType": "person",
          "id": "trello.samgamgee",
          "displayName": "Samwise Gamgee",
          "url": "http://trello.com/samgamgee",
          "image": {
            "url": "https://trello-avatars.s3.amazonaws.com/04efae26fd242a912663e3630551b6/170.png",
            "mediaType": "image/jpeg",
            "width": 170,
            "height": 170
          }
        },
        "object" : {
          "objectType": "trello.card",
          "id": "trello.546a650bc8837b1d5588a188"
          "url": "http://trello.com/c/BcoRhZxG",
          "displayName": "[2] Import all non-listing data from upper hutt onto production"
        },
        "target" : {
          "objectType": "trello.board",
          "id": "trello.53fc171865067982a4de41b2",
          "displayName": "PropertyNZ Sprint",
          "url": "http://trello.com/b/Az1wabpW"
        }
     })

  describe 'a changedCard event', ->
    it 'builds a valid activity', ->
      commentCard = loadFixture('changedCard')
      activity = converter.notificationToActivity(commentCard)
      expect(activity).to.deep.eq({
        "verb": {
          "id": "trello.changeCard",
          "displayName": "changed card"
        },
        "published": "2014-12-19T23:33:56.825Z",
        "language": "en",
        "actor": {
          "objectType": "person",
          "id": "trello.samgamgee",
          "displayName": "Samwise Gamgee",
          "url": "http://trello.com/samgamgee",
          "image": {
            "url": "https://trello-avatars.s3.amazonaws.com/04efae26fd242a912663e3630551b6/170.png",
            "mediaType": "image/jpeg",
            "width": 170,
            "height": 170
          }
        },
        "object" : {
          "objectType": "trello.card",
          "id": "trello.546a650bc8837b1d5588a188"
          "url": "http://trello.com/c/BcoRhZxG",
          "displayName": "[2] Import all non-listing data from upper hutt onto production"
        },
        "target" : {
          "objectType": "trello.board",
          "id": "trello.53fc171865067982a4de41b2",
          "displayName": "PropertyNZ Sprint",
          "url": "http://trello.com/b/Az1wabpW"
        }
     })
