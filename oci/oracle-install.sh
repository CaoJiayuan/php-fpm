#!/bin/sh

ls -l /tmp/ && \
unzip /tmp/instantclient-basic.zip -d /tmp && \
unzip /tmp/instantclient-sdk.zip  -d /tmp && \
ls -l /tmp && \
cp -r /tmp/instantclient_19_9/* /lib && \
rm -rf /tmp/instantclient-basic.zip && \
rm -rf /tmp/instantclient-sdk.zip && \
apk add libaio && \
apk add libaio libnsl libc6-compat && \
cd /lib && \
# Linking ld-linux-x86-64.so.2 to the lib/ location (Update accordingly)
ln -s /lib64/* /lib && \
ln -s libnsl.so.2 /usr/lib/libnsl.so.1 && \
ln -s /lib/ld-musl-x86_64.so.1 /usr/lib/libresolv.so.2

