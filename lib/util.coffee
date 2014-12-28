if Meteor.isClient
  share.toggle_bool = (name) ->
    console.log "toggle #{name}"
    Session.set name, not Session.get name
