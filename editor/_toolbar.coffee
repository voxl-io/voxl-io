if Meteor.isClient
  tools = [
    'color-swatch'
    'single-block'
    'draw-blocks'
    'erase-blocks'
    'eyedropper'
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
      # Split in case of additional active class.
      Session.set('editor_active_vertical_tool', event.target.className.split(' ')[0])

share.editor_toolbar =
  init: ->
    console.log 'toolbar reporting'

    Session.setDefault 'editor_color_selected', share.editor.get_random_color_indices()
    Session.set 'editor_active_vertical_tool', 'single-block'
