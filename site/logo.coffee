if Meteor.isClient
  logo_helpers =
    random: ->
      Session.get 'render-logo'
      Math.random() / 2 + 0.5

  Template.logo.helpers logo_helpers
  Template.dogear.helpers logo_helpers

  Meteor.setInterval ->
    Session.set 'render-logo', Math.random()
  , 2500
