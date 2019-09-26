#!/bin/sh
export PATH=/opt/rsdk-6.4.1-5281-EL-4.9-u1.0-m32fut-190129p1/bin:$PATH
export TOOL_PREFIX=mips-linux
export ROOTDIR=`pwd`

tar -xf libpcap-1.9.0.tar.gz
cd libpcap-1.9.0
./configure --prefix=${ROOTDIR}/libpcap_arm --host=mips-linux --with-pcap=linux ac_cv_linux_vers=2 CC=${TOOL_PREFIX}-gcc
make && make install

cd ../
tar -xf tcpdump-4.9.2.tar.gz
cd tcpdump-4.9.2
./configure --prefix=${ROOTDIR}/tcpdump_arm --host=${TOOL_PREFIX} CC=${TOOL_PREFIX}-gcc --with-system-libpcap=${ROOTDIR}/libpcap_arm
make && make install

#./tcpdump -i eth0 -s0 -w /mnt/eth0.pcap
#./tcpdump -i wlan0 -s0 -w /mnt/wlan0.pcap

