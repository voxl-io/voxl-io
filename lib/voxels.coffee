@share = share
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
    Voxels.remove({})
    if Voxels.find().count() is 0
      Voxels.insert
        _id: '0 0 0'
        color: '#f00'

  Meteor.publish 'my-voxels', ->
    Voxels.find()
