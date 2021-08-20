#!/bin/sh
wget https://download.oracle.com/otn_software/linux/instantclient/213000/instantclient-basiclite-linux.x64-21.3.0.0.0.zip
wget https://download.oracle.com/otn_software/linux/instantclient/213000/instantclient-sdk-linux.x64-21.3.0.0.0.zip
mkdir -p /opt/oracle
mv instantclient-* /opt/oracle
cd /opt/oracle
unzip instantclient-basiclite-linux.x64-21.3.0.0.0.zip
unzip instantclient-sdk-linux.x64-21.3.0.0.0.zip
rm instantclient-basiclite-linux.x64-21.3.0.0.0.zip
rm instantclient-sdk-linux.x64-21.3.0.0.0.zip