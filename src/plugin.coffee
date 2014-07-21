fs = require 'fs'
Sandbox = require 'sandbox'

module.exports = (env, callback) ->

  class SandboxPlugin extends env.ContentPlugin

    constructor: (@_filepath, @_text, @data) ->

    getFilename: ->
      (@data && @data["filename"]) ? @_filepath.relative

    getView: ->
      (env, locals, contents, templates, callback) ->
        callback null, new Buffer((@data && @data["template"]) ? @_text)

    SandboxPlugin.fromFile = (filepath, callback) ->
      fs.readFile filepath.full, (error, buffer) ->
        if error
          callback error
        else
          scriptContent = buffer.toString()

          @sandbox = new Sandbox()

          # The retunred message (= resultData) should be a
          # JSON object or a simple array.
          @sandbox.on 'message', (resultData) ->
            callback null,
            new SandboxPlugin(filepath, scriptContent, resultData)
          @sandbox.run scriptContent

  env.registerContentPlugin 'sandbox', '**/*.sandboxjs', SandboxPlugin

  # tell the plugin manager we are done
  callback()
