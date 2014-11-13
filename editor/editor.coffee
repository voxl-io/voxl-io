Voxels = share.Voxels
Colors = share.Colors

class @EditorController extends RouteController
  template: 'editor'

  waitOn: ->
    [
      Meteor.subscribe 'my-voxels'
      Meteor.subscribe 'my-colors'
    ]

  onBeforeAction: ->
    Session.setDefault 'editor_color_picker_enabled', no
    Session.setDefault 'editor_color_selected', '7 7 7'

    $(window).on 'keyup', (e) ->
      if e.which is 67 # C key
        share.toggle_bool 'editor_color_picker_enabled'

    Template.editor.helpers
      voxels: ->
        Voxels.find()
      colors: ->
        Colors.find()
      show_colors: ->
        Session.get 'editor_color_picker_enabled'

    Template.editor.events
      'mousedown shape, mouseup shape': (event) ->
        if event.type is 'mousedown'
          @lx = event.layerX
          @ly = event.layerY

        else
          return if @lx isnt event.layerX or @ly isnt event.layerY

          unless Session.get 'editor_color_picker_enabled'
            if event.button is 1
              x = Math.round(event.worldX + event.normalX) + 0
              y = Math.round(event.worldY + event.normalY) + 0
              z = Math.round(event.worldZ + event.normalZ) + 0

              console.log x, y, z, event

              return if y < 0 # keep voxels above ground

              color = '#' + Random.hexString(6)
              Voxels.insert
                _id: "#{x} #{y} #{z}"
                color: Colors.findOne(Session.get('editor_color_selected')).color
              , (err, id) ->
                err

            else Voxels.remove event.currentTarget.id if event.button is 4 or event.button is 2
          else
            Session.set 'editor_color_selected', event.currentTarget.id

    Template.editor.rendered = ->
      x3dom.reload()

    @next()

  data:
    route: 'editor'
