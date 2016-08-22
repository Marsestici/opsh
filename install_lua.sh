#! /bin/bash
wget -c $(get_ini lua src)
tar zxvf lua-5.3.3.tar.gz
cd lua-5.3.3
make linux
make install
cd ..
