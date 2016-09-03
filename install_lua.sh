#! /bin/bash
wget -c https://www.lua.org/ftp/lua-5.3.3.tar.gz
tar zxvf lua-5.3.3.tar.gz
cd lua-5.3.3
make linux
make install

