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

    $ overscore -n Templates -b example example/**/*.html > templates.js
