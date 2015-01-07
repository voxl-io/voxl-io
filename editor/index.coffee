share.editor =
  get_color: ->
    share.Colors.findOne(Session.get('editor_color_selected'))?.color or '#ccc'

  get_random_color_indices: ->
    (Math.floor(Math.random() * 8) for axis in ['x', 'y', 'z']).join ' '

class @EditorController extends RouteController
  template: 'editor'

  waitOn: ->
    [
      Meteor.subscribe 'my-voxels'
      Meteor.subscribe 'my-colors'
    ]

  onBeforeAction: ->
    share.editor_main.init()
    share.editor_toolbar.init()
    @next()

  # onAfterAction: ->

  data:
    route: 'editor'
