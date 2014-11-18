@share = share unless Meteor.settings?.production
share.Voxels = Voxels = new Mongo.Collection 'voxels'

if Meteor.isServer
  Voxels.allow
    insert: ->
      yes
    update: ->
      yes
    remove: ->
      yes

  Meteor.startup ->
    Voxels.remove {}

  Meteor.publish 'my-voxels', ->
    Voxels.find()
