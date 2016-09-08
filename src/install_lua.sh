#! /bin/bash
install_lua(){
    
    local url_path=$(get_ini lua src)
    local dir_name=$(get_ini global dlPath)/$(get_ini lua dir)
    
    if test ! -d $dir_name ;then
        mkdir -p $dir_name 2> /dev/null
    fi
    cd $dir_name
    wget -c $(get_ini lua src)
    tar zxvf lua-5.3.3.tar.gz
    cd lua-5.3.3
    make linux
    make install
    ln -s /usr/local/bin/lua /usr/bin/lua
    cd ..
}
