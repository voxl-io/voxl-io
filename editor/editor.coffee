class @EditorController extends RouteController
  template: 'editor'

  onAfterAction: ->
    Template.editor.rendered = ->
      scene = new THREE.Scene()
      camera = new THREE.PerspectiveCamera 75, window.innerWidth / window.innerHeight, 0.1, 1000
      renderer = new THREE.WebGLRenderer()
      @autorun =>
        div = @$('.renderer')
        renderer.setSize div.width(), div.height()
        div.append renderer.domElement

  data:
    route: 'editor'
    nologo: yes
