share.editor =
  get_color: =>
    share.Colors.findOne(Session.get('editor_color_selected'))?.color or '7 7 7'

  get_random_color_indices: ->
    (Math.floor(Math.random() * 8) for axis in ['x', 'y', 'z']).join ' '

class @EditorController extends RouteController
  template: 'editor'

  waitOn: ->
    [
      Meteor.subscribe 'my-voxels'
      Meteor.subscribe 'my-colors'
    ]

  onRun: ->
    share.editor_main.onRun()
    share.editor_toolbar.onRun()
    @next()

  onRerun: ->
    share.editor_main.onRun()
    share.editor_toolbar.onRun()
    @next()

  onBeforeAction: ->
    @next()

  data:
    route: 'editor'
