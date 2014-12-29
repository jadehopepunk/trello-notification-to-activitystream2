prefix = 'trello'
url = 'http://trello.com'
avatarSize = 170

actions = {
  commentCard: 
    displayName: 'commented on card'
    object: 'card'
  removedFromCard: 
    displayName: 'removed from card'
    object: 'card'
  addedToCard: 
    displayName: 'added to card'
    object: 'card'
  changeCard: 
    displayName: 'changed card'
    object: 'card'
  mentionedOnCard:
    displayName: 'mentioned on card'
    object: 'card'
  cardDueSoon:
    displayName: 'card due soon'
    object: 'card'
  addedToBoard:
    displayName: 'added to board'
    object: 'board'
}

objectTranslators = {
  board: (board) ->
    output =
      objectType: "#{prefix}.board"
      id: "#{prefix}.#{board.id}"
      displayName: board.name
    output.url = "#{url}/b/#{board.shortLink}" if board.shortLink
    output

  card: (card) ->
    output =
      objectType: "#{prefix}.card"
      id: "#{prefix}.#{card.id}"
      url: "#{url}/c/#{card.shortLink}"
      displayName: card.name
    output.endTime = card.due if card.due
    output
}

personObject = (person) ->
  if person
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
  displayName: actions[notificationType].displayName

resultForNotification = (notification) ->
  if notification.type == 'commentCard'
    {text: notification.data.text}

dataObject = (objectType, notification) ->
  objectData = notification.data[objectType]
  objectMethod = objectTranslators[objectType]

  objectMethod(objectData)

actionObject = (notification) ->
  objectType = actions[notification.type].object
  objectData = notification.data[objectType]
  objectMethod = objectTranslators[objectType]

  objectMethod(objectData)

actionTarget = (notification) ->
  objectType = actions[notification.type].object
  if objectType == 'card'
    targetType = 'board'
    dataObject 'board', notification
  else
    null

validNotificationToActivity = (notification) ->
  result = resultForNotification(notification)
  target = actionTarget(notification)
  actor = personObject(notification.memberCreator)

  output =
    verb:      verbObject(notification.type)
    published: notification.date
    language:  "en"
    object:    actionObject(notification)

  output.actor  = actor if actor
  output.target = target if target
  output.result = result if result
  output

errorObject = (original) ->
  error: 'unknown_notification_type'
  originalObject: original

module.exports =
  notificationToActivity: (notification) ->
    if notification.type && actions[notification.type]
      validNotificationToActivity(notification)
    else
      errorObject(notification)
