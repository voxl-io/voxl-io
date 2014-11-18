Router.configure
  layoutTemplate: 'layout'

Router.map ->
  @route 'home',
    path: '/'

  @route 'editor',
    path: '/editor'
    controller: 'EditorToolbarController'

  @route 'library',
    path: '/library'

  @route 'profile',
    path: '/profile'

  @route 'notFound',
    path: '*'
    where: 'server'
    action: ->
      @response.statusCode = 404
      @response.end '404'
