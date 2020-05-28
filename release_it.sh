#!/bin/sh

HOST_SYSTEM=`uname -s`
HOST_ARCH=`uname -m`

CMAKE_BUILDDIR=build-$HOST_ARCH-$HOST_SYSTEM
STARTDIR=`pwd`

#if [ "$HOST_SYSTEM" = "Linux" ] 
#then MYSQL_CONFIG=mysql_config
#else MYSQL_CONFIG=/opt/local/lib/mysql56/bin/mysql_config
#fi

mkdir -p $CMAKE_BUILDDIR

cd $CMAKE_BUILDDIR
rm CMakeCache.txt
cmake $STARTDIR
cmake --build . --target all 
cmake --build . --target all 
cmake --build . --target package 
cmake --build . --target dist
cmake --build . --target package_source
cd $STARTDIR

