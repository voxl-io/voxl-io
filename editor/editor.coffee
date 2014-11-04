class @EditorController extends RouteController
  template: 'editor'

  onAfterAction: ->
    Template.editor.rendered = ->
      @autorun =>
        div = @$('.renderer')
        width = div.width()
        height = div.height()
        scene = new THREE.Scene()
        camera = new THREE.PerspectiveCamera 75, width / height, 0.1, 1000
        renderer = new THREE.WebGLRenderer()
        renderer.setSize width, height
        div.append renderer.domElement
        geometry = new THREE.BoxGeometry(1, 1, 1)
        material = new THREE.MeshBasicMaterial(color: 0x00ff00)
        cube = new THREE.Mesh geometry, material
        scene.add cube
        camera.position.z = 5

        render = ->
          requestAnimationFrame render
          cube.rotation.x += 0.1
          cube.rotation.y += 0.1
          renderer.render scene, camera

        render()

  data:
    route: 'editor'
    nologo: yes
