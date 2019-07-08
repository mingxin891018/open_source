#########################################################################
# File Name: build_iconv.sh
# Author: weiyufeng
# mail:null
# Created Time: Sun 23 Jun 2019 04:28:29 PM CST
#########################################################################
#!/bin/sh
export PATH=/opt/rsdk-6.4.1-5281-EL-4.9-u1.0-m32fut-190129p1/bin:$PATH
export TOOL_PREFIX=mips-linux-

unzip wolfssl-4.0.0.zip
cd  wolfssl-4.0.0
cross=${TOOL_PREFIX%-}
./configure --prefix=$(pwd)/output  --host=${cross} --enable-shared --enable-sslv3 --enable-opensslextra --enable-truncatedhmac --enable-hkdf
make
make install
