#! /bin/sh
cd ~
wget http://luajit.org/download/LuaJIT-2.0.4.tar.gz
tar zxvf LuaJIT-2.0.4.tar.gz
cd LuaJIT-2.0.4
make PREFIX=/usr/local/luajit
make install PREFIX=/usr/local/luajit

cd /usr/local/src
wget https://github.com/simpl/ngx_devel_kit/archive/v0.3.0.tar.gz
tar zxvf v0.3.0.tar.gz

wget https://github.com/openresty/lua-nginx-module/archive/v0.10.7.tar.gz
tar zxvf v0.10.7.tar.gz

export LUAJIT_LIB=/usr/local/luajit/lib
export LUAJIT_INC=/usr/local/luajit/include/luajit-2.0

cd /home/opsh/nginx/nginx-1.10.1/
./configure --prefix=/usr/local/nginx  --with-ld-opt="-Wl,-rpath,/usr/local/luajit/lib" --add-module=/usr/local/src/ngx_devel_kit-0.3.0 --add-module=/usr/local/src/lua-nginx-module-0.10.7

make -j2
make install

mkdir /usr/local/nginx/logs/waf
chown -R nobody.nobody /usr/local/nginx/logs

service nginx restart
