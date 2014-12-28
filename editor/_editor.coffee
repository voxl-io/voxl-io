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

  draw_block = (event) ->
      x = Math.round(event.worldX + event.normalX) + 0
      y = Math.round(event.worldY + event.normalY) + 0
      z = Math.round(event.worldZ + event.normalZ) + 0

      return if y < 0 # keep voxels above ground

      color = '#' + Random.hexString(6)
      share.Voxels.insert
        _id: "#{x} #{y} #{z}"
        color: share.editor.get_color()
      , (err, id) ->
        err

  Template.editor.events
    'mousedown shape, mouseup shape': (event) ->
      if event.type is 'mousedown'
        @lx = event.layerX
        @ly = event.layerY

      else
        switch Session.get('editor_active_vertical_tool')
          when 'single-block'
            return if @lx isnt event.layerX or @ly isnt event.layerY
            draw_block event
          when 'draw-blocks'
            draw_block event
          when 'color-swatch'
            Session.set 'editor_color_selected', event.currentTarget.id
            Session.set('editor_active_vertical_tool', 'single-block')
          when 'erase-blocks'
            share.Voxels.remove event.currentTarget.id

  Template.editor.rendered = ->
    x3dom.reload()

share.editor_main =
  init: ->
    console.log 'editor reporting'
