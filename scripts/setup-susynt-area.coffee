# Description:
#   Utility commands to show our disk usage on /gdata/atalas
#
# Commands:
#   hubot area <susynt tag>

{spawn}        = require 'child_process'

# these will be stored in brain
knownReleases = ['n0145']
alreadyBuilt = []

module.exports = (robot) ->
  robot.respond /area (.*)$/i, (msg) ->
    release = msg.match[1]
    validRel = release in knownReleases
    if !validRel
       msg.send "Sorry, I don't know how to build #{release}"
    else
        buildDir = '/afs/cern.ch/user/g/gerbaudo/work/public/susy/bot/'
        process.chdir(buildDir)
        wget = spawn 'wget', ['-N', 'https://raw.github.com/gerbaudo/susynt-prod-log/master/bash/setup_area.sh']
        wget.stdout.on 'data', (data) -> msg.send data.toString().trim()
        ls = spawn 'ls', ['-la']
        ls.stdout.on 'data', (data) -> msg.send data.toString()
        chmod = spawn 'chmod', ['a+x','setup_area.sh']
        ls = spawn 'ls', ['-la']
        ls.stdout.on 'data', (data) -> msg.send "after: #{data.toString()}"
        build = spawn '/bin/bash', ['/afs/cern.ch/user/g/gerbaudo/work/public/susy/bot/setup_area.sh']
        build.stdout.on 'data', (data) -> msg.send data.toString()
        build.stderr.on 'data', (data) -> msg.send data.toString()
