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

    Template.editor.helpers
      radians: (opts) ->
        hash = opts.hash

        x = if hash.x then 1 else 0
        y = if hash.y then 1 else 0
        z = if hash.z then 1 else 0

        degrees = hash.x or hash.y or hash.z
        angle = degrees * Math.PI / 180

        "#{x} #{y} #{z} #{angle}"
      color: -> Session.get 'color'
      shader: -> Session.get 'shader'
      cpos: -> 'transform: translate3d(10, 0, 0)'

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
