#!/bin/bash
UPTIME="`uptime`" # Determine how long the system has been running
MYDATE=`TZ=MYT+16 date +%m-%d`

valid_host=$(hostname)


clear
echo "######################################"
echo "######    DNS Designation   ##########"
echo "######################################"
echo ""
displayhelp ()
{
    echo "Usage: server_report.sh"
    echo "       server_report.sh -v  (Displays version and exits)"
    echo "       server_report.sh -h  (Shows this message)"
}

displayversion ()
{
    echo "  Version 1.0.0, 4/29/2014, written by: RobO"
    echo "  Thank you for using this script. I hope you like it."
    echo "  If you have any improvements, please let me know!"
}

while getopts ":s:d:n:p:xvh" option; do
         case $option in
                 h)     displayhelp
                        exit 1
                        ;;
                 v)     displayversion
                        exit 1
                        ;;
                 \?)    echo "Invalid option: -$OPTARG" >&2
                        displayhelp
                        exit 1
                        ;;
         esac
done

echo " TODAYS Date $MYDATE  ..................... "
echo " THIS host is $valid_host"
#########  Anylyse the /etc/resolv.conf HERE ######
echo ""
echo "############## RESOLVE DNS file############# "
while read line
do

case $line in
*"10.200.1.1"*)
echo $line
echo " ..............GOT the first one "
;;

*"128.220"*)
echo $line
echo "THIS Server $(hostname) ... has an OLDER DNS designation in /etc/resolv.conf file "
echo ""
;;

*"10.200.2.2"*)
echo $line
echo " ..............GOT the second one "
echo ""
;;

#*"10.200"*)
#echo ""
#echo "THIS Server $(hostname) ... has at least ONE proper DNS servers named in its /etc/resolv.conf file "
#echo ""
#;;


*"disabled"*)
echo $line
;;
esac

done < /etc/resolv.conf
#  Clean up tmp file
echo " ... if necessary :  vim /etc/resolv.conf   ... "
