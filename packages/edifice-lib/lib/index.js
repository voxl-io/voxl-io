if (Meteor.isServer) {
  voxel = Npm.require('voxel')
  ray = Npm.require('voxel-raycast')
  aabb = Npm.require('aabb-3d')
  glMatrix = Npm.require('gl-matrix')
  vector = glMatrix.vec3
  SpatialEventEmitter = Npm.require('spatial-events')
  regionChange = Npm.require('voxel-region-change')
  tic = Npm.require('tic')()
  ndarray = Npm.require('ndarray')
  isndarray = Npm.require('isndarray')
  raf = Npm.require('raf')
}
