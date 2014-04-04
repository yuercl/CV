#!/bin/bash
#desgin for IP-Link Routers
BASIC_NAME=admin
BASIC_PASS=admin
InterIp=`ifconfig | sed -n '/Mask/p' | sed 's/127\.0\.0\.1//g' | sed -n '/192/p' | sed 's/:/ /g' | awk '{print $3}' | sed -n '/192/p' | head -1`
echo "ifconfig ip is $InterIp \n===================================="

MyIp=`curl -s http://iframe.ip138.com/ic.asp | sed -n '/\[/p' | sed 's/\[/ /g' | sed 's/\]/ /g' | awk '{print $3}'`
echo "Myip is $MyIp \n===================================="

MappedIp=`curl -s --user $BASIC_NAME:$BASIC_PASS http://192.168.1.1/userRpm/VirtualServerRpm.htm | sed -n '/\"192/p' | sed 's/[\",]/ /g' | awk '{print $3}'`
echo "MappedIp is $MappedIp  \n===================================="

DeleteAllMapUrl='http://192.168.1.1/userRpm/VirtualServerRpm.htm?doAll=DelAll&Page=1'
curl -s --user $BASIC_NAME:$BASIC_PASS $DeleteAllMapUrl>/dev/null
AddPort22="http://192.168.1.1/userRpm/VirtualServerRpm.htm?Port=22&Ip=$InterIp&Protocol=1&State=1&Commonport=0&Changed=0&SelIndex=0&Page=1&Save=%B1%A3+%B4%E6&curpage=1"
AddPort80="http://192.168.1.1/userRpm/VirtualServerRpm.htm?Port=80&Ip=$InterIp&Protocol=1&State=1&Commonport=0&Changed=0&SelIndex=0&Page=1&Save=%B1%A3+%B4%E6&curpage=1"
curl -s --user $BASIC_NAME:$BASIC_PASS $AddPort22 >/dev/null
curl -s --user $BASIC_NAME:$BASIC_PASS $AddPort80 >/dev/null