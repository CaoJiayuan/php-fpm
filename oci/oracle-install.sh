#!/bin/sh

wget https://download.oracle.com/otn_software/linux/instantclient/199000/instantclient-basic-linux.x64-19.9.0.0.0dbru.zip && \
wget https://download.oracle.com/otn_software/linux/instantclient/193000/instantclient-sdk-linux.x64-19.3.0.0.0dbru.zip && \    
    unzip instantclient-basic-linux.x64-19.9.0.0.0dbru.zip && \
    unzip instantclient-sdk-linux.x64-19.3.0.0.0dbru.zip && \
    cp -r instantclient_19_3/* /lib && \
    ls -l /lib && \
    rm -rf instantclient-basic-linux.x64-19.3.0.0.0dbru.zip && \
    apk add libaio && \
    apk add libaio libnsl libc6-compat && \
    cd /lib && \
    # Linking ld-linux-x86-64.so.2 to the lib/ location (Update accordingly)
    ln -s /lib64/* /lib && \
    ln -s libnsl.so.2 /usr/lib/libnsl.so.1 && \
    ln -s libc.so /usr/lib/libresolv.so.2

