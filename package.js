Package.describe({
  summary: "Layout",
  version: "0.0.1",
  name: "bads:alpha-layout"
});

Package.on_use(function (api, where, asset) {
  api.versionsFrom('METEOR@0.9.2-rc1');
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
    'token.html',
    'token_bootstrap.html',
    'token.js',
    'layout.coffee',
    'evt.coffee',
    'bootstrap.css',
    'bootstrap-theme.css',
    'layout.styl',
    'essential.styl'], 'client');
});

Package.on_test(function (api) {
  api.use("bads:alpha-layout");

  api.add_files('layout_tests.js', ['client', 'server']);
});
