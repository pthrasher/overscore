Overscore
=========

Overscore builds underscore.js templates on the server side for you, and
outputs a javascript you can include in the browser. It even supports AMD
output.

    $ overscore --help

    Usage: overscore [options] <files ...>

    Options:

        -h, --help                   output usage information
        -V, --version                output the version number
        -s, --silent                 Shortcut for --loglevel silent.
        -a, --amd                    Wrap output with define to make it AMD compatible.
        -n, --namespace <namespace>  Namespace under which templates should live. [Templates]
        -l, --loglevel <level>       Minimum log level to display. [info]
        -b, --basedir <basedir>      Base directory to keep out of namespacing.

Usage
-----

    $ npm install -g overscore
    $ overscore -n Templates -b example example/**/*.html > templates.js

### templates.js

```javascript
/*
 * Safely grab the namespace(s).
 */
var Templates = Templates != null ? Templates : {};

/*
 * Individual templates.
 */
Templates.Dashboard.base = function(obj){var __p='';var print=function(){__p+=Array.prototype.join.call(arguments, '')};with(obj||{}){__p+='<!DOCTYPE HTML>\n<html lang="en">\n<head>\n    <meta charset="UTF-8">\n    <title></title>\n</head>\n<body>\n    '+( "Hello, world." )+'\n</body>\n</html>';}return __p;};
Templates.Dashboard.item = function(obj){var __p='';var print=function(){__p+=Array.prototype.join.call(arguments, '')};with(obj||{}){__p+='<div class="view">\n    <input class="toggle" type="checkbox" '+( done ? 'checked="checked"' : '' )+' />\n    <label>'+( title )+'</label>\n    <a class="destroy"></a>\n</div>\n<input class="edit" type="text" value="'+( title )+'" />';}return __p;};
Templates.Dashboard.stats = function(obj){var __p='';var print=function(){__p+=Array.prototype.join.call(arguments, '')};with(obj||{}){__p+=''; if (done) { ;__p+='\n    <a id="clear-completed">\n        Clear '+( done )+' completed '+( done == 1 ? 'item' : 'items' )+'\n    </a>\n'; } ;__p+='\n\n<div class="todo-count">\n    <b>'+( remaining )+'</b> '+( remaining == 1 ? 'item' : 'items' )+' left\n</div>';}return __p;};
Templates.Profile.admin.base = function(obj){var __p='';var print=function(){__p+=Array.prototype.join.call(arguments, '')};with(obj||{}){__p+='<!DOCTYPE HTML>\n<html lang="en">\n<head>\n    <meta charset="UTF-8">\n    <title></title>\n</head>\n<body>\n    '+( "Hello, world." )+'\n</body>\n</html>';}return __p;};
Templates.Profile.admin.item = function(obj){var __p='';var print=function(){__p+=Array.prototype.join.call(arguments, '')};with(obj||{}){__p+='<div class="view">\n    <input class="toggle" type="checkbox" '+( done ? 'checked="checked"' : '' )+' />\n    <label>'+( title )+'</label>\n    <a class="destroy"></a>\n</div>\n<input class="edit" type="text" value="'+( title )+'" />';}return __p;};
Templates.Profile.admin.stats = function(obj){var __p='';var print=function(){__p+=Array.prototype.join.call(arguments, '')};with(obj||{}){__p+=''; if (done) { ;__p+='\n    <a id="clear-completed">\n        Clear '+( done )+' completed '+( done == 1 ? 'item' : 'items' )+'\n    </a>\n'; } ;__p+='\n\n<div class="todo-count">\n    <b>'+( remaining )+'</b> '+( remaining == 1 ? 'item' : 'items' )+' left\n</div>';}return __p;};
Templates.Profile.user.base = function(obj){var __p='';var print=function(){__p+=Array.prototype.join.call(arguments, '')};with(obj||{}){__p+='<!DOCTYPE HTML>\n<html lang="en">\n<head>\n    <meta charset="UTF-8">\n    <title></title>\n</head>\n<body>\n    '+( "Hello, world." )+'\n</body>\n</html>';}return __p;};
Templates.Profile.user.item = function(obj){var __p='';var print=function(){__p+=Array.prototype.join.call(arguments, '')};with(obj||{}){__p+='<div class="view">\n    <input class="toggle" type="checkbox" '+( done ? 'checked="checked"' : '' )+' />\n    <label>'+( title )+'</label>\n    <a class="destroy"></a>\n</div>\n<input class="edit" type="text" value="'+( title )+'" />';}return __p;};
Templates.Profile.user.stats = function(obj){var __p='';var print=function(){__p+=Array.prototype.join.call(arguments, '')};with(obj||{}){__p+=''; if (done) { ;__p+='\n    <a id="clear-completed">\n        Clear '+( done )+' completed '+( done == 1 ? 'item' : 'items' )+'\n    </a>\n'; } ;__p+='\n\n<div class="todo-count">\n    <b>'+( remaining )+'</b> '+( remaining == 1 ? 'item' : 'items' )+' left\n</div>';}return __p;};
```
