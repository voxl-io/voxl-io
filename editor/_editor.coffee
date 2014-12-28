if Meteor.isClient
  Template.editor.helpers
    voxels: ->
      share.Voxels.find()
    colors: ->
      bbox = Session.get 'editor_color_picker_bbox'

      select =
        $nor: [
          x:
            $in: [bbox.xmin + 1 .. bbox.xmax - 1]
          y:
            $in: [bbox.ymin + 1 .. bbox.ymax - 1]
          z:
            $in: [bbox.zmin + 1 .. bbox.zmax - 1]
        ]

      console.log select
      results = share.Colors.find select
      console.log "Displaying #{results.count()} out of #{Math.pow(8, 3)}"
      results

    show_colors: ->
      Session.get('editor_active_vertical_tool') is 'color-swatch'

  Template.editor.events
    'mousedown shape, mouseup shape': (event) ->
      if event.type is 'mousedown'
        @lx = event.layerX
        @ly = event.layerY

      else
        return if @lx isnt event.layerX or @ly isnt event.layerY

        unless Session.get('editor_active_vertical_tool') is 'color-swatch'
          if event.button is 1
            x = Math.round(event.worldX + event.normalX) + 0
            y = Math.round(event.worldY + event.normalY) + 0
            z = Math.round(event.worldZ + event.normalZ) + 0

            console.log x, y, z, event

            return if y < 0 # keep voxels above ground

            color = '#' + Random.hexString(6)
            share.Voxels.insert
              _id: "#{x} #{y} #{z}"
              color: share.editor.get_color()
            , (err, id) ->
              err

          else share.Voxels.remove event.currentTarget.id if event.button is 4 or event.button is 2
        else
          Session.set 'editor_color_selected', event.currentTarget.id
          Session.set('editor_active_vertical_tool', 'single-block')

  Template.editor.rendered = ->
    x3dom.reload()

share.editor_main =
  init: ->
    console.log 'editor reporting'
