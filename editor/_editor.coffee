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

    nav_mode: ->
      tool = Session.get('editor_active_vertical_tool')
      unless tool is 'draw-blocks' or tool is 'erase-blocks'
        'turntable'
      else
        'none'

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

  erase_block = (event) ->
    share.Voxels.remove event.currentTarget.id

  draw_block_throttled = _.throttle draw_block, 250
  erase_block_throttled = _.throttle erase_block, 250

  Template.editor.events
    'mousedown shape, mousemove shape, mouseup shape': (event) ->
      if event.type is 'mousedown'
        @lx = event.layerX
        @ly = event.layerY
        Session.set 'mouse_down', yes
      else
        switch Session.get('editor_active_vertical_tool')
          when 'single-block'
            if event.type is 'mouseup'
              return if @lx isnt event.layerX or @ly isnt event.layerY
              draw_block_throttled event
          when 'color-swatch'
            if event.type is 'mouseup'
              Session.set 'editor_color_selected', event.currentTarget.id
              Session.set('editor_active_vertical_tool', 'single-block')
          when 'draw-blocks'
            if Session.get 'mouse_down'
              draw_block_throttled event
          when 'erase-blocks'
            if Session.get 'mouse_down'
              erase_block_throttled event

      if event.type is 'mouseup'
        Session.set 'mouse_down', no

  Template.editor.rendered = ->
    x3dom.reload()

share.editor_main =
  init: ->
    console.log 'editor reporting'
