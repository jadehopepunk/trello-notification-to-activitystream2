boardObject = (board) ->
  objectType: "trello.board"
  id: "trello.#{board.id}"
  displayName: board.name
  url: "http://trello.com/b/#{board.shortLink}"

cardObject = (card) ->
  objectType: "trello.card"
  id: "trello.#{card.id}"
  url: "http://trello.com/c/#{card.shortLink}"
  displayName: card.name

personObject = (person) ->
  result =
    objectType: "person"
    id: "trello.#{person.username}"
    displayName: person.fullName
    url: "https://trello.com/#{person.username}"
  if person.avatarHash
    result.image = imageObject(person.avatarHash)
  result

imageObject = (avatarHash) ->
  url: "https://trello-avatars.s3.amazonaws.com/#{avatarHash}/170.png"
  mediaType: "image/jpeg"
  width: 170
  height: 170

module.exports =
  notificationToActivity: (notification) ->
    verb:
      id: "trello.commentCard"
      displayName: "comment on card"
    published: notification.date
    language: "en"
    actor:
      personObject(notification.memberCreator)
    object:
      cardObject(notification.data.card)
    target:
      boardObject(notification.data.board)
