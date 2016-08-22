#! /bin/bash
install_git(){

    if [ $(whereis -b gits | tr ' ' '\n' | wc -l) -gt 1 ];then
        echo "git has intalled in this machine";install
    else
		
        local url_path="https://github.com/git/git/archive/v2.9.3.zip"
        local dir_name=$envpath"/git"
        if [ ! -d $dir_name ];then 
            mkdir -p $dir_name 2> /dev/null
        fi
        if [ $? -eq 0 ];then
            cd $dir_name;
			wget $url_path 
			unzip v2.9.3.zip	
			cd git-2.9.3	
            autoconf
			./configure && make && make install
            echo "Git Complete install";
			install
        else
            echo "install git faild"
        fi
    fi
}
