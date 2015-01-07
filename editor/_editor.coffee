if Meteor.isClient
  Template.editor.helpers
    voxels: ->
      share.Voxels.find()

    colors: ->
      bbox = Session.get 'editor_color_picker_bbox'

      select =
          x:
            $in: [bbox.xmin .. bbox.xmax]
          y:
            $in: [bbox.ymin .. bbox.ymax]
          z:
            $in: [bbox.zmin .. bbox.zmax]

      results = share.Colors.find select
      console.log "Displaying #{results.count()} out of #{Math.pow(8, 3)}"
      results

    show_colors: ->
      bbox =
        xmin: 0
        ymin: 0
        zmin: 0
        xmax: 7
        ymax: 7
        zmax: 7

      Session.set 'editor_color_picker_bbox', bbox
      'color-swatch' is Session.get 'editor_active_vertical_tool'

    nav_mode: ->
      tool = Session.get('editor_active_vertical_tool')
      unless tool is 'draw-blocks' or tool is 'erase-blocks'
        'turntable'
      else
        'none'

    handles: ->
      bbox = Session.get 'editor_color_picker_bbox'

      [
        _id: 'nnn'
        _pos: "#{bbox.xmin - 1} #{bbox.ymin - 1} #{bbox.zmin - 1}"
      ,
        _id: 'pnn'
        _pos: "#{bbox.xmax + 1} #{bbox.ymin - 1} #{bbox.zmin - 1}"
      ,
        _id: 'npn'
        _pos: "#{bbox.xmin - 1} #{bbox.ymax + 1} #{bbox.zmin - 1}"
      ,
        _id: 'nnp'
        _pos: "#{bbox.xmin - 1} #{bbox.ymin - 1} #{bbox.zmax + 1}"
      ,
        _id: 'ppn'
        _pos: "#{bbox.xmax + 1} #{bbox.ymax + 1} #{bbox.zmin - 1}"
      ,
        _id: 'npp'
        _pos: "#{bbox.xmin - 1} #{bbox.ymax + 1} #{bbox.zmax + 1}"
      ,
        _id: 'pnp'
        _pos: "#{bbox.xmax + 1} #{bbox.ymin - 1} #{bbox.zmax + 1}"
      ,
        _id: 'ppp'
        _pos: "#{bbox.xmax + 1} #{bbox.ymax + 1} #{bbox.zmax + 1}"
      ]

    config_handle: (handle_id) ->
      setTimeout =>
        x3el = $('#x3dom-editor')[0]
        $handle = $('#' + @)

        move_cb = (elem, trans) ->
          bbox = Session.get 'editor_color_picker_bbox'
          dirs = elem.id.split('')
          axes = ['x', 'y', 'z']

          for dir, i in dirs
            axis = axes[i]
            if dir is 'n'
              # console.log 'min', bbox["#{axis}min"]
              bbox["#{axis}min"] += trans[axis] if bbox["#{axis}min"] > 0 and bbox["#{axis}min"] > 0
            else
              # console.log 'max', bbox["#{axis}max"]
              bbox["#{axis}max"] += trans[axis] if bbox["#{axis}max"] < 8 and bbox["#{axis}max"] > 0

          Session.set 'editor_color_picker_bbox', bbox

        move_cb_throttled = _.throttle move_cb, 500

        if $handle[0]
          new x3dom.Moveable x3el, $handle[0], move_cb_throttled, 1.0
      , 0

      null

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
              if event.currentTarget.className is 'color'
                return if @lx isnt event.layerX or @ly isnt event.layerY
                Session.set 'editor_color_selected', event.currentTarget.id
                Session.set('editor_active_vertical_tool', 'single-block')
              else if event.currentTarget.className is 'handle'
                console.log event
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
