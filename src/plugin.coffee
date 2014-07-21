###
/* vim: set tabstop=4:softtabstop=4:shiftwidth=4:noexpandtab */
// kate: replace-tabs on; indent-width 4; indent-mode cstyle;
###

fs = require 'fs'
Sandbox = require 'sandbox'

module.exports = (env, callback) ->

    class SandboxPlugin extends env.ContentPlugin

        constructor: (@_filepath, @_text, @data) ->
            @sandbox = new Sandbox()

        getFilename: ->
            @_filepath.relative

        getView: ->
            (env, locals, contents, templates, callback) ->
                callback null, new Buffer @_text

        SandboxPlugin.fromFile = (filepath, callback) ->
            fs.readFile filepath.full, (error, buffer) ->
                if error
                    callback error
                else
                    # The retunred message (= resultData) should be a JSON object or a simple array.
                    @sandbox.onmessage = (resultData) ->
                        callback null, new SandboxPlugin(filepath, buffer.toString(), resultData))
                    @sandbox.run(buffer.toString())

    env.registerContentPlugin 'database', '**/*.(sandboxed.js|js)', SandboxPlugin
    callback() # tell the plugin manager we are done
