class @EditorController extends RouteController
  template: 'editor'

  onAfterAction: ->
    Session.setDefault 'color', '1 1 1'
    Session.setDefault 'shader', 'matte'

    Template.editor.events
      'click .color button': (e) ->
        console.log $(e.target).text()
        Session.set 'color', $(e.target).data('color')

      'click .shader button': (e) ->
        console.log $(e.target).text()
        Session.set 'shader', '#' + $(e.target).text()

    Template.editor.color = ->
      Session.get 'color'

    Template.editor.shader = ->
      Session.get 'shader'

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
