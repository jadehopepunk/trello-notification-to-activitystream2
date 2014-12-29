prefix = 'trello'
url = 'http://trello.com'
avatarSize = 170

displayNames = {
  commentCard: 'commented on card'
  removedFromCard: 'removed from card'
  addedToCard: 'added to card'
  changeCard: 'changed card'
}

boardObject = (board) ->
  objectType: "#{prefix}.board"
  id: "#{prefix}.#{board.id}"
  displayName: board.name
  url: "#{url}/b/#{board.shortLink}"

cardObject = (card) ->
  objectType: "#{prefix}.card"
  id: "#{prefix}.#{card.id}"
  url: "#{url}/c/#{card.shortLink}"
  displayName: card.name

personObject = (person) ->
  output =
    objectType: "person"
    id: "#{prefix}.#{person.username}"
    displayName: person.fullName
    url: "#{url}/#{person.username}"
  if person.avatarHash
    output.image = imageObject(person.avatarHash)
  output

imageObject = (avatarHash) ->
  url: "https://trello-avatars.s3.amazonaws.com/#{avatarHash}/#{avatarSize}.png"
  mediaType: "image/jpeg"
  width: avatarSize
  height: avatarSize

verbObject = (notificationType) ->
  id: "trello.#{notificationType}"
  displayName: displayNames[notificationType]

resultForNotification = (notification) ->
  if notification.type == 'commentCard'
    {text: notification.data.text}

module.exports =
  notificationToActivity: (notification) ->
    result = resultForNotification(notification)

    output =
      verb:
        verbObject(notification.type)
      published: notification.date
      language: "en"
      actor:
        personObject(notification.memberCreator)
      object:
        cardObject(notification.data.card)
      target:
        boardObject(notification.data.board)
    output.result = result if result
    output