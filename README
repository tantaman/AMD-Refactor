AMD Refactor
============

Currently really simple tools to help in moving AMD modules around.

If you've moved an AMD module and want to update all of your define() calls in your project to point to the new module:

`rake refactor[old/module/import/statement,new/module/import/statement]`

If you want to figure out the dependencies of a given package:

`rake showDeps[package/import/path]`

showDeps is currently not recursive!  It'll only show one layer of dependencies.

One variable you'll want to configure in the rakefile is BASE_DIR.  Point that to the base directory which contains your modules.  If you are using the default requirejs setup then you would point BASE_DIR to your scripts directory.

