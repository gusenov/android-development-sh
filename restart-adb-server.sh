#!/bin/bash
#set -x  # echo on

# Usage:
#  $ ./restart-adb-server.sh -m=tcpip -p=49151 -h=192.168.1.100 -s="/opt/google/Android/Sdk" -n="a5add4de"
#  $ ./restart-adb-server.sh -h=192.168.1.100 -s="/opt/google/Android/Sdk" -n="a5add4de"
#  $ ./restart-adb-server.sh -m=usb -s="/opt/google/Android/Sdk" -n="a5add4de"

# Экспериментально выяснил, что на порты до 1023 включительно подключение не проходит:
# unable to connect to 192.168.1.100:955: Connection refused

port=49151
mode="tcpip"
host="192.168.1.100"
android_sdk_location="/opt/google/Android/Sdk"
serial_number="a5add4de"

for i in "$@"
do
case $i in
    -m=*|--mode=*)
        mode="${i#*=}"
        shift  # past argument=value
        ;;
    -p=*|--port=*)
        port="${i#*=}"
        shift  # past argument=value
        ;;
    -h=*|--host=*)
        host="${i#*=}"
        shift  # past argument=value
        ;;
    -s=*|--sdk=*)
        android_sdk_location="${i#*=}"
        shift  # past argument=value
        ;;
    -n=*|--number=*)
        serial_number="${i#*=}"
        shift  # past argument=value
        ;;
esac
done

adb_location="$android_sdk_location/platform-tools/adb"

function adb_tcpip_and_connect()
{
    # Restart the adb server listening on TCP at the specified port.
    $adb_location -s $3 tcpip $1  # tcpip port-number
    
    # Connect to a device over TCP/IP. If you do not specify a port, then the default port, 5555, is used.
    $adb_location -s $3 connect "$2:$1"  # connect host[:port]
}

function adb_usb()
{
    # Restart the adb server listening on USB.
    $adb_location -s $1 usb
}

$adb_location kill-server
sleep 4

# Как сделать case для строки:
# https://stackoverflow.com/a/2283814/2289640

case "$mode" in
    ("tcpip") adb_tcpip_and_connect $port $host $serial_number ;;
    ("usb") adb_usb $serial_number ;;
esac

sleep 4
$adb_location devices
