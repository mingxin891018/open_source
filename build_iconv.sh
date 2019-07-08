#########################################################################
# File Name: build_iconv.sh
# Author: weiyufeng
# mail:null
# Created Time: Sun 23 Jun 2019 04:28:29 PM CST
#########################################################################
#!/bin/sh
export PATH=/opt/rsdk-6.4.1-5281-EL-4.9-u1.0-m32fut-190129p1/bin:$PATH
export TOOL_PREFIX=mips-linux-

tar zxf libiconv-1.16.tar.gz
cd  libiconv-1.16
cross=${TOOL_PREFIX%-}
./configure --prefix=$(pwd)/output  --host=${cross}
make
make install

#说明本 libiconv-1.16.tar.gz 经过裁剪，保留UTF-8到GB2312的转换
