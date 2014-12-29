module.exports = {
  notificationToActivity: (notification) ->
    {
      "verb": {
        "id": "trello.commentCard",
        "displayName": "comment on card"
      },
      "published": notification.date,
      "language": "en",
      "actor": {
        "objectType": "person",
        "id": "trello.#{notification.memberCreator.username}",
        "displayName": notification.memberCreator.fullName,
        "url": "https://trello.com/#{notification.memberCreator.username}",
        "image": {
          "url": "https://trello-avatars.s3.amazonaws.com/#{notification.memberCreator.avatarHash}/170.png",
          "mediaType": "image/jpeg",
          "width": 170,
          "height": 170
        }
      },
      "object" : {
        "objectType": "trello.card",
        "id": "trello.#{notification.data.card.id}"
        "url": "http://trello.com/c/#{notification.data.card.shortLink}",
        "displayName": notification.data.card.name
      },
      "target" : {
        "objectType": "trello.board",
        "id": "trello.#{notification.data.board.id}",
        "displayName": notification.data.board.name,
        "url": "http://trello.com/b/#{notification.data.board.shortLink}"
      }
    }
  }