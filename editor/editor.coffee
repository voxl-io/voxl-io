class @EditorController extends RouteController
  template: 'editor'

  onAfterAction: ->
    # Template.registerHelper 'xml', ->
    #   console.log 'harbl'
    #   'harbl'

    Session.setDefault 'color', '1 1 1'

    Template.editor.events
      'click button': (e) ->
        console.log $(e.target).text()
        Session.set 'color', $(e.target).data('color')

    Template.editor.color = ->
      Session.get 'color'

    Template.editor.rendered = ->
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
