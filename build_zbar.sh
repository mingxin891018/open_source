#########################################################################
# File Name: build_zbar.sh
# Author: weiyufeng
# mail:null
# Created Time: Sun 23 Jun 2019 04:29:52 PM CST
#########################################################################
# 使用uclib请先编译iconv
#!/bin/sh
export PATH=/opt/rsdk-6.4.1-5281-EL-4.9-u1.0-m32fut-190129p1/bin:$PATH
export TOOL_PREFIX=mips-linux-

tar xjvf zbar-0.10.tar.bz2
cd zbar-0.10
cross=${TOOL_PREFIX%-}
./configure --prefix=$(pwd)/output --host=${cross} --disable-video --without-gtk --without-python --without-qt --without-imagemagick
make
make install

# 说明使用Uclib编译的话，会缺少iconv的相关函数支持，请先编译出iconv,本zbar开源软件中makeflile.in已经指定了
#编译的iconv头文件的路径，确保zbar和iconv开源软件同一目录。
