#! /bin/bash

wget -c http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz
tar zxvf ctags-5.8.tar.gz
cd ctags-5.8
./configure && make && make install
. ./install_lua.sh
wget -c ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
tar jxf vim-7.4.tar.bz2
cd vim74/
sed -i '/luaL_optlong/s/luaL_optlong/(long)luaL_optinteger/' if_lua.c
./configure --with-features=huge \
    --enable-cscope \
    --enable-rubyinterp \
    --enable-largefile \
    --enable-multibyte \
    --disable-netbeans \
    --enable-luainterp \
    --with-lua-prefix=/usr/local \
    --enable-pythoninterp \
    --enable-cscope --prefix=/usr
make && make install
curl https://j.mp/spf13-vim3 -L > spf13-vim.sh && sh spf13-vim.sh
sed -i '$r ~/.vimrc.local' conf/vimrc
