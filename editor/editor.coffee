class @EditorController extends RouteController
  template: 'editor'

  onAfterAction: ->
    Template.editor.events = {}

    Template.editor.helpers
      cube_pos: -> 'transform: translate3d(10, 0, 0)'

    Template.editor.rendered = ->
      # hack
      window.initXML3DElement $('xml3d')[0]
      setTimeout ->
        $('canvas').attr
          width: 600
          height: 600
        $('canvas').parent().css
          display: 'block'
      , 1000

  onStop: ->
    $('canvas').parent().remove()

  data:
    route: 'editor'
    nologo: yes
