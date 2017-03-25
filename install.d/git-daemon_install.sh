#!/bin/bash

# git-daemon-run 依赖 runit，runit 又依赖 upstart，适用于 UpStart 系统
# git-daemon-sysvinit 顾名思义，适用于 SysV 系统

if [ -z $AIU ]; then
  AIU=$(dirname $(cd `dirname $0`;pwd))
fi

if [ -f $AIU/install.d/functions.sh ]; then
  source $AIU/install.d/functions.sh
fi

if [ -z `dpkg -l | awk '{print $2}' | grep ^git-daemon-sysvinit$` ]; then
  apt_install git-daemon-sysvinit
  is_ok
fi

if [ -z `cat /etc/group | cut -d ":" -f 1 | grep ^git$` ]; then
  groupadd git
fi
if [ -z `cat /etc/passwd | cut -d ":" -f 1 | grep ^git$` ]; then
  useradd -r -M -g git -s /bin/false git
fi

sed -i '
/GIT_DAEMON_ENABLE/s/=.*/=true/
/GIT_DAEMON_USER/s/=.*/=git/
/GIT_DAEMON_BASE_PATH/s/=.*/=\/opt\/git/
/GIT_DAEMON_DIRECTORY/s/=.*/=\/opt\/git/
/GIT_DAEMON_OPTIONS/s/".*"/"--reuseaddr \
--export-all \
--enable=upload-pack \
--enable=upload-archive \
--enable=receive-pack \
--informative-errors"/
' /etc/default/git-daemon

/etc/init.d/git-daemon restart
