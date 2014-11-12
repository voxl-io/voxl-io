if Meteor.isClient
  Template.logo.helpers
    random: ->
      Session.get 'render-logo'
      Math.random()

  Meteor.setInterval ->
    Session.set 'render-logo', Math.random()
  , 2500
