_       = require 'underscore'
fs      = require 'fs'
log     = require 'npmlog'
path    = require 'path'
program = require 'commander'
version = require('./package.json').version

removeByteOrderMark = (text) ->
    if  text.charCodeAt(0) is 0xfeff
        return text.substring 1
    text

slugify = (text) ->
    for nono in nonos
        text = text.replace nono, ''
    text

templateSrc = (html) ->
    compiled = _.template(html)
    compiled.source.replace(/\n+/g, '')

getAllFiles = (fsPaths, re=null) ->
    log.verbose 'fsPaths', fsPaths
    files = []
    for fsPath in fsPaths
        log.verbose 'fsPath', fsPath
        stats = fs.statSync fsPath
        if stats.isDirectory()
            _fsPaths = fs.readdirSync fsPath
            log.verbose '_fsPaths', _fsPaths

            for _fsPath in _fsPaths
                realPath = path.join(fsPath, _fsPath)
                log.verbose 'realPath', realPath
                _files = getAllFiles [realPath]
                for _file in _files
                    files.push _file
        else if stats.isFile()
            handleFile = true
            if re?
                if fsPath.match re
                    files.push fsPath
            else
                files.push fsPath
    files

startsWith = (needle, haystack) ->
    haystack.indexOf(needle) is 0

buildIdentifier = (filePath) ->
    cleanPath = filePath
    if program.basedir
        if startsWith program.basedir, cleanPath
            cleanPath = cleanPath.replace program.basedir, ''
            if cleanPath.indexOf('/') is 0
                cleanPath = cleanPath[1..]
    extname = path.extname cleanPath
    basename = path.basename cleanPath, extname
    log.verbose 'cleanPath', cleanPath
    log.verbose 'basename', basename
    slug = slugify basename
    if cleanPath.indexOf('/') is -1
        identifier = "#{program.namespace}.#{slug}"

    else
        identifierParts = [program.namespace]
        for part in path.dirname(cleanPath).split '/'
            newPart = slugify part
            if newPart.length
                identifierParts.push newPart
        identifierParts.push slug
        identifier = identifierParts.join '.'
    identifier

nonos = ['`', '~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_',
             '+', '-', '=', '[', ']', '{', '}', '\\', '|', ';', ':', '\'', '"',
             ',', '<', '.', '>', '/', '?']

exports.main = (args) ->
    program
        .version(version)
        .option('-s, --silent', 'Shortcut for --loglevel silent.')
        .option('-n, --namespace <namespace>', 'Namespace under which templates should live. [Templates]', String, 'Templates')
        .option('-l, --loglevel <level>', 'Minimum log level to display. [info]', String, 'info')
        .option('-b, --basedir <basedir>', 'Base directory to keep out of namespacing.')
        .parse(args)

    log.level = program.loglevel
    if program.silent
        log.level = 'silent'

    log.verbose 'args', args
    log.verbose 'args', program.args

    templates = getAllFiles(program.args).map (filePath) ->
        log.verbose 'filePath', filePath
        name = slugify path.basename(filePath, path.extname(filePath))
        contents = fs.readFileSync filePath, 'utf8'
        contents = removeByteOrderMark contents.trim()
        unless contents?
            log.error name, "Could not read file contents, skipping. [#{filePath}]"
            return
        identifier = buildIdentifier filePath
        src = templateSrc contents
        line = "#{identifier} = #{src};"
        log.info 'compiled', "[#{filePath}] #{identifier}"
        line

    templates = templates.filter (template) ->
        return template

    if templates.length
        console.log "/*\n * Safely grab the namespace(s).\n */"
        if program.namespace.indexOf('.') > -1
            nsParts = program.namespace.split '.'
            for item, i in nsParts
                if i is 0
                    console.log "var #{item} = #{item} != null ? #{item} : {};"
                else
                    id = nsParts[..i].join('.')
                    console.log "#{id} = #{id} != null ? #{id} : {};"
        else
            console.log "var #{program.namespace} = #{program.namespace} != null ? #{program.namespace} : {};"
        console.log "\n/*\n * Individual templates.\n */"
        console.log templates.join '\n'
