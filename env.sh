#!/bin/sh

echo "create the chatroom from indico"
XMPP_PASSWD=""
XMPP_USERNAME=""
read    -p "Enter bot xmpp username: " XMPP_USERNAME
read -s -p "Enter bot xmpp password: " XMPP_PASSWD
echo ""
export HUBOT_XMPP_USERNAME="${XMPP_USERNAME}"
export HUBOT_XMPP_PASSWORD="${XMPP_PASSWD}"
export HUBOT_XMPP_ROOMS="susynt_chat@conference.jabber.cern.ch"
export HUBOT_XMPP_HOST="conference.jabber.cern.ch"
#export HUBOT_XMPP_PORT="5222"

