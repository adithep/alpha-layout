Package.describe({
  summary: "Layout"
});

Package.on_use(function (api, where, asset) {
  api.use([
    'coffeescript',
    'core-lib',
    'utilities',
    'alpha-auth',
    'accounts-base',
    'alpha-stylus',
    "htmljs",
    "html-tools",
    "spacebars-compiler",
    'standard-app-packages']);
  api.add_files([
    'layout.html',
    'layout.coffee',
    'layout.styl',
    'essential.styl'], 'client');
});

Package.on_test(function (api) {
  api.use('alpha-layout');

  api.add_files('layout_tests.js', ['client', 'server']);
});
