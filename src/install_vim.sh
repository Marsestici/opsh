#! /bin/bash
install_vim(){

    local url_path=$(get_ini vim ctag)
    local dir_name=$(get_ini global dlPath)/$(get_ini vim dir);
    if test ! -d $dir_name ;then
        mkdir -p $dir_name 2> /dev/null
    fi
    cd $dir_name
    wget -c $url_path

    tar zxvf ctags-5.8.tar.gz
    cd ctags-5.8
    ./configure && make && make install
    cd ..

    . $opshPath/src/install_lua.sh
    wget -c $(get_ini vim src)
    tar jxf vim-7.4.tar.bz2
    cd vim74/
    sed -i '/luaL_optlong/s/luaL_optlong/(long)luaL_optinteger/' src/if_lua.c
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
    curl $(get_ini vim spf13) -l > spf13-vim.sh && sh spf13-vim.sh
    cd ..
    sed '$r ~/.vimrc.local' $opshPath/conf/vimrc > ~/.vimrc.local
}
