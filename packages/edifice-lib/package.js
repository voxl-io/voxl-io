Package.describe({
  summary: 'Edifice Voxel Libraries',
  version: '0.0.0',
  name: 'edifice:edifice-lib'
});

Npm.depends({
  "aabb-3d": "0.1.0",
  "collide-3d-tilemap": "0.0.1",
  "extend": "1.2.1",
  "gl-matrix": "2.2.1",
  "inherits": "2.0.1",
  "isndarray": "0.1.0",
  "ndarray": "1.0.15",
  "ndarray-fill": "1.0.1",
  "raf": "2.0.4",
  "spatial-events": "1.1.0",
  "spatial-trigger": "0.0.0",
  "tic": "0.2.1",
  "voxel": "https://github.com/deathcap/voxel/archive/2a92d917199aedc89267c60eb0687d3472a7ce2f.tar.gz",
  "voxel-fakeao": "0.1.1",
  "voxel-raycast": "0.2.1",
  "voxel-region-change": "0.1.0",
  "voxel-shader": "0.13.1",
  "voxel-mesher": "0.14.0"
});

Package.onUse(function(api) {
  api.addFiles('lib/index.js', ['client', 'server']);
  api.export('voxel', 'client');
  api.export('ray', 'client');
  api.export('aabb', 'client');
  api.export('glMatrix', 'client');
  api.export('vector', 'client');
  api.export('SpatialEventEmitter', 'client');
  api.export('regionChange', 'client');
  api.export('tic', 'client');
  api.export('raf', 'client');
  api.export('ndarray', 'client');
  api.export('isndarray', 'client');
});
