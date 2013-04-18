fs            = require 'fs'
which         = require 'which'
{spawn, exec} = require 'child_process'

# ANSI Terminal Colors
bold  = '\x1B[0;1m'
red   = '\x1B[0;31m'
green = '\x1B[0;32m'
reset = '\x1B[0m'

log = (message, color, explanation) ->
  console.log color + message + reset + ' ' + (explanation or '')

compile_options = ['-c', '-o', '.', 'coffee']
# Compiles src in coffee directory to js in root directory
build = (callback)->
  cmd = which.sync 'coffee'
  coffee = spawn cmd, compile_options
  coffee.stdout.pipe process.stdout
  coffee.stderr.pipe process.stderr
  coffee.on 'exit', (status) -> callback?() if status is 0

# callback never run in watch_coffee, cause coffee didnt exit when it is watching
watch_coffee = (callback)->
  compile_options.unshift '-w'
  # console.log compile_options
  build(callback)

test_server = (callback)->
  process.env.PORT = 5000
  options = ['app.js']
  cmd = which.sync 'node'
  test_app = spawn cmd, options, {detached: true, stdio: ['ignore', 'ignore', process.stderr]}
  test_app.unref()
  callback()
  test_app.pid

app = ->
  options = ['app.js']
  cmd = which.sync 'supervisor'
  process.env.PORT = 3333
  app = spawn cmd, options
  app.stdout.pipe process.stdout
  app.stderr.pipe process.stderr

testing = (app_pid)->
  options = ['test']
  cmd = which.sync 'webspecter'
  t = spawn cmd, options
  # not worked. cause phantomjs didnt support running with Node
  t.stdout.pipe process.stdout
  t.stderr.pipe process.stderr
  t.on 'exit', (status) -> process.kill(app_pid)

task 'build', ->
  build -> log "done", green

task 'watch_build', ->
  watch_coffee -> log "watch coffee dir", green

task 'test', ->
  build ->
    pid = test_server()
    # console.log(pid)
    testing(pid)

task 'test_server', ->
  build -> test_server -> log "test app starting : ", green

task 'app', ->
  watch_coffee -> log "watch coffee dir", green
  app()