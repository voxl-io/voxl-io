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

      # Code to store a 'color-cube'
      cube_length = 32
      x = 0
      col_x = 255

      console.log "Starting to create documents for color-cube"

      while x < cube_length
        y = 0
        col_y = 255

        while y < cube_length
          z = 0
          col_z = 255

          while z < cube_length
            Voxels.insert
              _id: "#{x} #{y} #{z}"
              color: "##{col_x.toString(16)}#{col_y.toString(16)}#{col_z.toString(16)}"
              # console.log "##{col_x.toString(16)}#{col_y.toString(16)}#{col_z.toString(16)}"
            z++
            col_z -= col_z//cube_length

          y++
          col_y -= col_y//cube_length

        x++
        col_x -= col_x//cube_length

        console.log "#{x*100/cube_length}%" # Display a progress meter in the logs

      console.log "Done adding documents for the color-cube!"

  Meteor.publish 'my-voxels', ->
    Voxels.find()
