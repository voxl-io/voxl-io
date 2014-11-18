class @EditorToolbarController extends @EditorController
  tools: [
    'color-swatch'
    'single-block'
    'draw-block'
    'eraser'
  ]

  onBeforeAction: =>
    console.log 'toolbar reporting'

    Template.editor_toolbar.helpers
      color_swatch_style: =>
        color = @get_color()

      vertical_tools: =>
        tool_classes = []
        for tool in @tools
          tool_classes.push
            tool_class: if Session.get('editor-active-vertical-tool') then tool else "#{tool} active"
            tool_style: if tool is 'color-swatch' then "style='background-color: #{@get_color()};'" else ''
        tool_classes

    @next()
