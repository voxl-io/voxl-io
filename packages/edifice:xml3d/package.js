Package.describe({
  name: 'edifice:xml3d',
  summary: 'xml3d.js',
  version: '0.4.7',
});

Package.onUse(function(api) {
  api.versionsFrom('1.0');
  api.use('jquery');
  api.addFiles('lib/xml-visitor.js', 'client');
  api.addFiles('lib/xml3d.js', 'client');
  api.addFiles('lib/xml3d-camera.js', 'client');
  api.export('XML3D', 'client');
});
