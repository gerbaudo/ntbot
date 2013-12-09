# Description:
#   Utility commands to show our disk usage on /gdata/atalas
#
# Commands:
#   hubot dugdata disk udage on gdata

fs             = require 'fs'
{spawn}        = require 'child_process'

# this is not working
# get_top_5 = (items) ->
#   keys = (k for k,v of items)
#   sortedKeys = keys.sort (a, b) -> items[b] - items[a]
#   sortedKeys[...5]

module.exports = (robot) ->
  robot.respond /dugdata/i, (msg) ->
    pwd = process.env.PWD
    quota = 9.6*1024
    kb2gb  = 1.0/(1024*1024)
    origin = 'gerbaudo@gpatlas1.ps.uci.edu:/gdata/atlas/du_atlas'
    dest   = '/tmp/du_atlas'
    scp = spawn '/bin/bash', ['scp', origin, dest]
    scp.stdout.on 'data', (data) -> msg.send 'fetching info'
    scp.stderr.on 'data', (data) -> msg.send data.toString()
    fileText = fs.readFileSync(dest).toString()
    lines = fileText.split('\n')
    totalSize = 0
    usrSize = {}
    for l,i in lines
        tokens = l.split(/\s+/)
        if tokens.length < 2
           continue
        gb = parseInt(tokens[0])*kb2gb
        user = tokens[1]
        if user=='total'
           totalSize = gb
        else
           usrSize[user] = gb
    msg.send "total : #{totalSize.toFixed(2)} / #{quota}"
    topOffenders = {}
    topOffenders[u] = v for u, v of usrSize when v / totalSize > 0.1
    msg.send "top users :"
    for k,u of topOffenders
        msg.send "#{k} #{u.toFixed(2)}"

