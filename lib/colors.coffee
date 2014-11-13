@share = share
share.Colors = Colors = new Mongo.Collection 'colors'
share.cube_length = cube_length = 8

if Meteor.isServer
  rgb2hex = (red, green, blue) ->
    rgb = blue | (green << 8) | (red << 16)
    "#" + (0x1000000 + rgb).toString(16).slice(1)

  Colors.allow
    insert: ->
      yes
    update: ->
      yes
    remove: ->
      yes

  Meteor.startup ->
    Colors.remove {}

    if Colors.find().count() is 0
      # Code to store a 'color-cube'
      incr = Math.round 256 / cube_length
      x = 0
      col_x = 0

      console.log "Starting to create documents for color-cube"

      for x in [0...cube_length]
        y = 0
        col_y = 0

        for y in [0...cube_length]
          z = 0
          col_z = 0

          for z in [0...cube_length]
            Colors.insert
              _id: "#{x} #{y} #{z}"
              x: x
              y: y
              z: z
              color: rgb2hex col_x, col_y, col_z
            , (err, id)->
              yes # noop

            z++
            col_z += incr

          y++
          col_y += incr

        x++
        col_x += incr

        console.log "#{x*100/cube_length}%" # Display a progress meter in the logs

      console.log "Done adding documents for the color-cube!"

  Meteor.publish 'my-colors', ->
    c = cube_length - 1

    select =
      $nor: [
        x:
          $in: [1...c]
        y:
          $in: [1...c]
        z:
          $in: [1...c]
      ]

    console.log select

    results = Colors.find select

    console.log "Displaying #{results.count()} out of #{Math.pow(cube_length, 3)}"

    results
