#!/bin/bash

echo -e '\033[49;32m'
echo "Building  ... 【Openssl】"
echo -e '\033[0m'

export PATH=/opt/goke/4.6.1/usr/bin:$PATH
sleep 1
COMPILER_TOOL="arm-linux"
COMPILER_NAME_PREFIX="${COMPILER_TOOL}-gcc"
ROOT_PATH=$PWD
OPENSSL_VERSION="openssl-1.0.2r"
OUT_DIR="$ROOT_PATH/out/$OPENSSL_VERSION"

cd $ROOT_PATH/$OPENSSL_VERSION

#./config no-asm shared --prefix=$OUT_DIR
echo "./config  no-asm shared os/compiler:${COMPILER} --prefix=$OUT_DIR"
./config  no-asm shared os/compiler:${COMPILER_NAME_PREFIX} --prefix=$OUT_DIR
echo "sed -i  "s/CC= gcc/CC= ${COMPILER_NAME_PREFIX}/g" Makefile"
sed -i  "s/CC= gcc/CC=${COMPILER_NAME_PREFIX}/g" Makefile
sed -i 's/-march=pentium//g' Makefile
sed -i 's/-m64//g' Makefile
cd  -

#======详细指导方法  V1.0 ==============
#在arm平台下编译的动态库方法:
#1:
##export PATH=/工具链路径:$PATH
#2:
##./config no-asm shared --prefix=编译后的库，配置工具等目录路径
#不编译部分汇编代码
#
#3.改Makefile
#   1） CC= gcc 改成 CC = $(TOOL_PREFIX)-gcc；
#   2） 删除 CFLAG= 中的 “-march=pentium”；
#   3） AR=ar $(ARFLAGS) r 改为 AR=$(TOOL_PREFIX)-ar $(ARFLAGS) r；
#   4） ARD=ar $(ARFLAGS) d 改为 ARD=$(TOOL_PREFIX)-ar $(ARFLAGS) d；
#   5）RANLIB= /usr/bin/ranlib 改为 RANLIB= $(TOOL_PREFIX)-ranlib；
#   其中$(TOOL_PREFIX)为交叉编译工具链
#4.编译
#   #make
#   #make install;//这步可以去掉吧??
#5.将生成的crypto和ssl动态库拷贝到平台的第3方库中（连接时顺序为ssl在前crypto在后)
#
#
#eg:海思3716Mv410上编译
#1: AR="arm-histbv300-linux-ar" RANLIB=arm-histbv300-linux-ranlib  CC=arm-histbv300-linux-gcc 
#   ./config  no-asm shared os/compiler:arm-histbv300-linux-gcc --prefix="./out"
#2:在上一步的基础上修改Makefile
#	修改SHLIB_EXT的值为 .so.$(SHLIB_MAJOR).$(SHLIB_MINOR)
#	修改SHLIB_TARGET的值为 linux-shared
#	在build_all 后面依赖列表里增加 build-shared
