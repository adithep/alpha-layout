Package.describe({
  summary: "Layout",
  version: "0.0.1"
});

Package.on_use(function (api, where, asset) {
  api.versionsFrom("METEOR-CORE@0.9.0-atm");
  api.use([
    'bads:core-lib',
    'bads:utilities',
    'bads:alpha-auth',
    'bads:alpha-stylus',
    'accounts-base',
    'coffeescript',
    "spacebars-compiler",
    'standard-app-packages'
  ]);
  api.add_files([
    'layout.html',
    'atem.html',
    'layout.coffee',
    'layout.styl',
    'essential.styl'], 'client');
});

Package.on_test(function (api) {
  api.use("../packages/bads:alpha-layout");

  api.add_files('layout_tests.js', ['client', 'server']);
});
