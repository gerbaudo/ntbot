#!/bin/sh

echo "setting up kerberos auth"
kinit -f -r 25h $USER@CERN.CH
aklog
echo "please run crontab -e and add the line below"
echo "@daily ID=afstoken kinit -R"

echo "please create the chatroom from indico"
XMPP_PASSWD=""
XMPP_USERNAME=""
read    -p "Enter username@jabber.cern.ch : " XMPP_USERNAME
read -s -p "Enter bot xmpp password: " XMPP_PASSWD
echo ""
export HUBOT_XMPP_USERNAME="${XMPP_USERNAME}"
export HUBOT_XMPP_PASSWORD="${XMPP_PASSWD}"
export HUBOT_XMPP_ROOMS="susynt_chat@conference.jabber.cern.ch"
export HUBOT_XMPP_HOST="conference.jabber.cern.ch"
#export HUBOT_XMPP_PORT="5222"

