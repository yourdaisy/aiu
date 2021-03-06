#!/bin/bash

# 执行过程没有交互操作，所以不会确认删除已安装的软件包
# 也不会删除任何已安装的软件包,仅仅是对安装位置有无指定安装目录的检查
# 现在加入对包管理器安装软件包的检查

# # PATH
# PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# export PATH

AIU=$(cd `dirname $0`;pwd)
. $AIU/install.d/functions.sh


$AIU/install.d/vim_install.sh
is_ok
$AIU/install.d/git_install.sh
is_ok
$AIU/install.d/git-daemon_install.sh
is_ok
$AIU/install.d/node_install.sh
is_ok
$AIU/install.d/httpd_install.sh
is_ok
$AIU/install.d/httpd_config.sh
is_ok
$AIU/install.d/subversion_install.sh
is_ok

# if [ -d $AIU/install.d ]; then
#   for i in $AIU/install.d/*.sh
#   do
#     if [ -x $i ]; then
#       $i
#       is_ok $i
#     fi
#   done
#   unset i
# fi
