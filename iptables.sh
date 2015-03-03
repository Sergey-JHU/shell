#!/bin/sh
SERVER_IP=128.220.106.xxx
iptables -F
#iptables -A INPUT -s 128.220.106.0/255.255.255.0 -d $SERVER_IP -p tcp -m tcp --dport 22 -j ACCEPT

#Disable ping

#iptables -A OUTPUT -s $SERVER_IP -p icmp --icmp-type echo-request -j DROP

#Allow HUB server web access

iptables -A OUTPUT -s  $SERVER_IP -d  128.220.106.59 -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -s  $SERVER_IP -d  128.220.106.60 -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -s  $SERVER_IP -d  10.175.133.157 -p tcp --dport 80 -j ACCEPT

#Allow SVN server web access

iptables -A OUTPUT -s  $SERVER_IP -d  128.220.106.218 -p tcp --dport 80 -j ACCEPT

# Allow SVN access connection
iptables -A INPUT -p tcp -i eth0 --dport 3690 -j ACCEPT



#ALOOW Nagios to communicate VIA NRPE -- RobO
iptables -A INPUT -s 128.220.106.17  -p tcp -m tcp --dport 5666 -j ACCEPT



#To drop outgoing httpd requests uncomment the following two lines

#iptables -A OUTPUT -s  $SERVER_IP -p tcp --dport 80 -j DROP
#iptables -A OUTPUT -s  $SERVER_IP -p tcp --dport 443 -j DROP

#Allow outgoing SSH

#iptables -A OUTPUT -s  $SERVER_IP -d 128.220.106.244 -p tcp --dport 22 -j ACCEPT


#Disable outging SSH

#iptables -A OUTPUT -s $SERVER_IP -d 128.220.106.0/255.255.255.0 -p tcp --dport 22 -j DROP
#iptables -A OUTPUT -s $SERVER_IP -d 10.175.133.0/255.255.255.0 -p tcp --dport 22 -j DROP
#iptables -A OUTPUT -s $SERVER_IP -d 10.175.132.0/255.255.255.0 -p tcp --dport 22 -j DROP

#Allow related, established

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -i eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
#Allow related, established

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -i eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -m state --state NEW,RELATED,ESTABLISHED -j ACCEPT

#BAD GUYS (Block Source IP Address):
# iptables -A INPUT -s 172.34.5.8 -j DROP

#Blocking ports

#iptables -A INPUT -p tcp --dport 1015 -j DROP

#NO SPAMMERS (notice the use of FQDN):
#iptables -A INPUT -s mail.spammer.org -d 10.1.15.1 -p tcp --dport 25 -j REJECT
#THEN OPEN IT UP:-----------------------------------------------------------------------

#MYSQL (Allow Remote Access To Particular IP):
iptables -A INPUT -d $SERVER_IP -p tcp --dport 3306 -j ACCEPT

#SSH: incoming

iptables -A INPUT -s 128.220.106.0/255.255.255.0 -d $SERVER_IP -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -s 10.171.1.0/255.255.255.0 -d $SERVER_IP -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -s 10.171.63.0/255.255.255.0 -d $SERVER_IP -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -s 10.171.62.0/255.255.255.0 -d $SERVER_IP -p tcp --dport 22 -j ACCEPT

# iptables -A INPUT -d $SERVER_IP -p tcp --dport 22 -j ACCEPT

#BackupExec

iptables -A INPUT -s 128.220.106.237 -d $SERVER_IP -p tcp -i eth0 --dport 10000 -j ACCEPT
iptables -A INPUT -s 128.220.106.201 -d $SERVER_IP -p tcp -i eth0 --dport 10000 -j ACCEPT

iptables -A INPUT -s 128.220.106.237 -d $SERVER_IP -p tcp --dport 1024:65535 -j ACCEPT
iptables -A INPUT -s 128.220.106.201 -d $SERVER_IP -p tcp --dport 1024:65535 -j ACCEPT

#Sendmail/Postfix:
iptables -A INPUT -d $SERVER_IP -p tcp --dport 25 -j ACCEPT

#FTP: (Notice how you can specify a range of ports 20-21)
# iptables -A INPUT -d $SERVER_IP -p tcp --dport 20:21 -j ACCEPT
#Passive FTP Ports Maybe: (Again, specifying ports 50000 through 50050 in one rule)
# iptables -A INPUT -d $SERVER_IP -p tcp --dport 50000:50050 -j ACCEPT

#HTTP/Apache
#For production web server the following rule, to open for all
#iptables -A INPUT -d $SERVER_IP -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -d $SERVER_IP -p tcp --dport 8080 -j ACCEPT

#If web server need to open from limited networks
#iptables -A INPUT -s 128.220.106.0/255.255.255.0 -d $SERVER_IP -p tcp --dport 80 -j ACCEPT
#iptables -A INPUT -s 10.175.133.0/255.255.255.0 -d $SERVER_IP -p tcp --dport 80 -j ACCEPT
#iptables -A INPUT -s 10.175.132.0/255.255.255.0 -d $SERVER_IP -p tcp --dport 80 -j ACCEPT
#iptables -A INPUT -s 10.175.132.0/255.255.255.0 -d $SERVER_IP -p tcp --dport 8080 -j ACCEPT
#iptables -A INPUT -s 10.175.133.0/255.255.255.0 -d $SERVER_IP -p tcp --dport 8080 -j ACCEPT
#iptables -A INPUT -s 128.220.106.0/255.255.255.0 -d $SERVER_IP -p tcp --dport 8080 -j ACCEPT

#iptables -A INPUT -s 128.220.106.0/255.255.255.0 -d $SERVER_IP -p tcp --dport 8080 -j ACCEPT

#SSL/Apache
iptables -A INPUT -d $SERVER_IP -p tcp --dport 443 -j ACCEPT

#IMAP
# iptables -A INPUT -d $SERVER_IP -p tcp --dport 143 -j ACCEPT

#IMAPS
# iptables -A INPUT -d $SERVER_IP -p tcp --dport 993 -j ACCEPT
#POP3
# iptables -A INPUT -d $SERVER_IP -p tcp --dport 110 -j ACCEPT

#POP3S
# iptables -A INPUT -d $SERVER_IP -p tcp --dport 995 -j ACCEPT

#Any Traffic From Localhost:
 iptables -A INPUT -s 127.0.0.1 -j ACCEPT

#MySql

#iptables -A INPUT -d $SERVER_IP -s 192.168.30.41 -i eth0 -p tcp --destination-port 3306 -j ACCEPT
iptables -A INPUT -i eth0 -p tcp --destination-port 3306 -j ACCEPT
#iptables -A INPUT -i eth0 -p tcp --destination-port 1433 -d $SERVER_IP -s localhost -j ACCEPT

#LDAP OUTGOING
#LDAP OUTGOING

#iptables -A INPUT  -p tcp -s 128.220.106.244 -d $SERVER_IP --dport 636 -j ACCEPT
#iptables -A OUTPUT  -p tcp -s $SERVER_IP -d 128.220.106.244 --dport 636 -j ACCEPT
#iptables -A INPUT  -p tcp -s 128.220.106.217 -d $SERVER_IP --dport 636 -j ACCEPT
#iptables -A OUTPUT  -p tcp -s $SERVER_IP -d 128.220.106.217 --dport 636 -j ACCEPT

#ICMP/Ping:
#iptables -A INPUT -d $SERVER_IP -s 192.168.30.0/24 -p icmp -j ACCEPT
iptables -A INPUT -s 128.220.106.0/255.255.255.0 -d $SERVER_IP -p icmp -j ACCEPT
iptables -A INPUT -s 10.171.1.0/255.255.255.0 -d $SERVER_IP -p icmp -j ACCEPT
iptables -A INPUT -s 10.171.62.0/255.255.255.0 -d $SERVER_IP -p icmp -j ACCEPT
iptables -A OUTPUT -s $SERVER_IP -d 128.220.106.0/255.255.255.0 -p icmp -j ACCEPT
iptables -A OUTPUT -s $SERVER_IP -d 10.171.63.0/255.255.255.0 -p icmp -j ACCEPT
iptables -A OUTPUT -s $SERVER_IP -d 10.171.62.0/255.255.255.0 -p icmp -j ACCEPT
#iptables -A OUTPUT -s $SERVER_IP -d 128.220.106.1 -p icmp -j ACCEPT
#iptables -A OUTPUT -p icmp -o eth0 -j DROP
#Genoss required services

#iptables -A INPUT -p udp --dport 514 -j ACCEPT
#iptables -A INPUT -p udp --dport 162 -j ACCEPT
#GLOBAL REJECTS LAST:

#-----------------------------------------------------------------------

#Reject everything else to that IP:

iptables -A INPUT -d $SERVER_IP -j REJECT
iptables -A INPUT -d $SERVER_IP -j DROP
iptables -A OUTPUT -s $SERVER_IP -j DROP

#Or, reject everything else coming through to any IP:
# iptables -A INPUT -j REJECT
#iptables -A OUTPUT -j DROP
# iptables -A FORWARD -j REJECT-----------------------------------------------------------------------

service iptables save

#iptables -A INPUT -s 128.220.106.0/255.255.255.0 -d $SERVER_IP -p tcp -m tcp --dport 22 -j ACCEPT
#service iptables save
#For ip forwaring to configure a router-gateway
#iptables -A POSTROUTING -o eth0 -j MASQUERADE
