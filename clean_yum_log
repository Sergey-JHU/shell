#!/bin/sh
#
#
#       We have a yum log on TEST ---I want the exact SAME updates on PROD
#       .... so I have to put yum CMDS and clean it up
#       SED & AWK do that nicely
#       ---RobO MAY 2014
#
#
if [[ $# -eq 0 ]] ; then
    echo 'ERROR:        You need a LOG file and A TO file ...usally /var/log/yum-temp.log'
    exit 0
fi
sed 's/Updated:/update/g
s/Erased:/erase/g
/Installed/d
/openssl/d' $1 | awk '{print"yum -y "$4" "$5}' > $2

####  now add the She-bNG
ed -s $2 <<< $'1i\n#!/bin/sh\n.\nwq'
### NOW REMIND YOURSELF TO DO STUFF
echo " Now --- SCP the output to the PROD server  ...."
echo "%>scp new_file.txt your_username@remotehost.edu:foobar.txt"
echo "%>scp /root/YumUp/yum.log.MAY19 rosteen@dev---p1.dev.jhu.edu:/home/rosteen "
