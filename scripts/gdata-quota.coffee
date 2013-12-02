# Description:
#   Utility commands to show our disk usage on /gdata/atalas
#
# Commands:
#   hubot dugdata disk udage on gdata

fs             = require 'fs'

# this is not working
# get_top_5 = (items) ->
#   keys = (k for k,v of items)
#   sortedKeys = keys.sort (a, b) -> items[b] - items[a]
#   sortedKeys[...5]

module.exports = (robot) ->
  robot.respond /dugdata/i, (msg) ->
    pwd = process.env.PWD
    # ssh gerbaudo@gpatlas2.ps.uci.edu "cat /gdata/atlas/du_atlas" > /tmp/du_atlas
    quota = 9.6*1024
    kb2gb  = 1.0/(1024*1024)
    fileText = fs.readFileSync("/tmp/du_atlas").toString()
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

