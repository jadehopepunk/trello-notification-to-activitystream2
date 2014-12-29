map = require("through2-map").obj
converter = require('./object_converter')

module.exports = () ->
  map converter
