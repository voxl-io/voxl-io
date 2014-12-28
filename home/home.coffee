class @HomeController extends RouteController
  template: 'home'

  data:
    route: 'home'

if Meteor.isClient
  Template.home.helpers
    live: ->
      window.location.hash is '#live'
