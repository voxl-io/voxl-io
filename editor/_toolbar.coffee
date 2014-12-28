if Meteor.isClient
  tools = [
    'color-swatch'
    'single-block'
    'draw-blocks'
    'eraser'
  ]

  Template.editor_toolbar.helpers
    vertical_tools: ->
      tool_classes = []
      for tool in tools
        tool_classes.push
          tool_class: if Session.get('editor_active_vertical_tool') is tool then "#{tool} active" else tool
          tool_style: if tool is 'color-swatch' then "style='background-color: #{share.editor.get_color()};'" else ''
      tool_classes

  Template.editor_toolbar.events
    'click .vertical-toolbar button': (event) ->
      Session.set('editor_active_vertical_tool', event.target.className)

share.editor_toolbar =
  init: ->
    console.log 'toolbar reporting'

    Session.setDefault 'editor_color_selected', share.editor.get_random_color_indices()

    bbox =
      xmin: 0
      ymin: 0
      zmin: 0
      xmax: 7
      ymax: 7
      zmax: 7

    Session.setDefault 'editor_color_picker_bbox', bbox

    Session.set 'editor_active_vertical_tool', 'single-block'
