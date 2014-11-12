Voxels = share.Voxels

class @EditorController extends RouteController
  template: 'editor'

  waitOn: ->
    [
      Meteor.subscribe 'my-voxels'
    ]

  onBeforeAction: ->
    Template.editor.helpers
      voxels: ->
        Voxels.find()

    Template.editor.events
      'mousedown shape, mouseup shape': (event) ->
        if event.type is 'mousedown'
          @lx = event.layerX
          @ly = event.layerY

        else
          return if @lx isnt event.layerX or @ly isnt event.layerY

          if event.button is 1
            x = Math.round(event.worldX + event.normalX) + 0
            y = Math.round(event.worldY + event.normalY) + 0
            z = Math.round(event.worldZ + event.normalZ) + 0

            console.log x, y, z, event

            return if y < 0 # keep voxels above ground

            color = '#' + Random.hexString(6)
            Voxels.insert
              _id: "#{x} #{y} #{z}"
              color: color
            , (err, id) ->
              err

          else Voxels.remove event.currentTarget.id if event.button is 4 or event.button is 2

    Template.editor.rendered = ->
      x3dom.reload()

    @next()

  data:
    route: 'editor'
