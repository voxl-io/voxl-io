if Meteor.isClient
  tools = [
    'color-swatch'
    'single-block'
    'draw-block'
    'eraser'
  ]

  Template.editor_toolbar.helpers
    color_swatch_style: ->
      color = share.editor.get_color()

    vertical_tools: ->
      tool_classes = []
      for tool in tools
        tool_classes.push
          tool_class: if Session.get('editor-active-vertical-tool') then tool else "#{tool} active"
          tool_style: if tool is 'color-swatch' then "style='background-color: #{share.editor.get_color()};'" else ''
      tool_classes

  Template.editor_toolbar.events
    'click .color-swatch': (e) ->
      console.log 'clicked!'
      share.toggle_bool 'editor_color_picker_enabled'

share.editor_toolbar =

  init: ->
    console.log 'toolbar reporting'

    Session.set 'editor_color_picker_enabled', no
    Session.set 'editor_color_selected', share.editor.get_random_color_indices()
