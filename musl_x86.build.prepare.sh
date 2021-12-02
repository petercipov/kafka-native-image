#!/bin/sh

#musl gcc
curl -fsSL -o x86_64-linux-musl-native.tgz http://musl.cc/x86_64-linux-musl-native.tgz
tar -xvf x86_64-linux-musl-native.tgz
cd x86_64-linux-musl-native
export TOOLCHAIN_DIR=`pwd`
export CC=$TOOLCHAIN_DIR/bin/gcc
cd ..
echo "TOOLCHAIN_DIR: $TOOLCHAIN_DIR"
echo "CC: $CC"


#zlib
curl -fsSL -o zlib-1.2.11.tar.gz https://zlib.net/zlib-1.2.11.tar.gz
tar -xvf zlib-1.2.11.tar.gz

cd zlib-1.2.11
./configure --prefix=$TOOLCHAIN_DIR --static
make
make install
cd ..

export PATH="$TOOLCHAIN_DIR/bin:$PATH"
