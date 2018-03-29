#!/bin/bash
set -e
USERID=${USERID:-1000}
GROUPID=${GROUPID:-1000}
groupadd -g ${GROUPID} weechat
useradd -m -u ${USERID} -g ${GROUPID} weechat
gosu ${USERID}:${GROUPID} ${USERNAME} /opt/weechat/bin/weechat
