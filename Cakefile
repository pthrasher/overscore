cs     = require 'coffee-script'
fs     = require 'fs'
log    = require 'npmlog'
jsp    = require("uglify-js").parser
pro    = require("uglify-js").uglify
semver = require 'semver'

building = false
_build = ->
    return if building
    building = true
    fs.readFile 'overscore.coffee', 'utf8', (err, contents) ->
        if err?
            log.error 'file-read', "Couldn't read contents of overcore.coffee: #{util.format err}"
            building = false
            return
        log.info 'file-read', "Retrieved overscore.coffee contents."
        try
            js = cs.compile contents
        catch err
            log.info 'compile', "Compile errors: #{util.format err}"
            building = false
            return
        log.info 'compile', 'Successfully compiled overscore.coffee.'
        log.info 'uglify', 'Parsing AST'
        ast = jsp.parse js
        log.info 'uglify', 'Mangling AST'
        ast = pro.ast_mangle ast
        log.info 'uglify', 'Squeezing AST'
        ast = pro.ast_squeeze ast
        log.info 'uglify', 'Generating JS from AST'
        js = pro.gen_code ast

        log.info 'file-write', 'Writing out index.js.'
        fs.writeFile 'index.js', js, 'utf8', (err) ->
            if err?
                log.error 'file-write', "Couldn't write to index.js: #{util.format err}"
                building = false
                return
            log.info 'file-write', 'Done.'
            _bump()
            building = false

_watch = ->
    fs.watchFile 'overscore.coffee', { persistent: true, interval: 25 }, (event, filename) ->
        _build()
        
_bump = (level='build') ->
    log.info 'semver', "Bumping #{level}."
    fs.readFile 'package.json', 'utf8', (err, contents) ->
        try
            pkg = JSON.parse(contents)
        catch err
            log.error 'json', "Couldn't parse package.json: #{util.format err}"
        
        oldSemver = pkg.version
        newSemver =  semver.inc(pkg.version, level)
        pkg.version = newSemver
        fs.writeFile 'package.json', JSON.stringify(pkg, null, '    '), 'utf8', (err) ->
            if err?
                log.error 'json', "Couldn't write package.json: #{util.format err}"
            log.info 'semver', "#{oldSemver} -> #{newSemver}"

task 'build', 'Just compiles / minifies the main package.', ->
    _build()

task 'watch', 'Watches overscore.coffee, and auto-builds when it changes.', ->
    _watch()

task 'bump:minor', 'Bumps that minor version number.', ->
    _bump 'minor'

task 'bump:major', 'Bumps that minor version number.', ->
    _bump 'major'

task 'bump:patch', 'Bumps that minor version number.', ->
    _bump 'patch'

task 'bump:build', 'Bumps that minor version number.', ->
    _bump()
