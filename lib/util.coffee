if Meteor.isClient
  share.toggle_bool = (name) ->
    Session.set name, not Session.get name
