#! /bin/bash
# 200 301 302 Content-Length
clear
echo "Now detection remote source code valid..."
sleep 3s
src_status=0
get_header() {
    read content;
    for url in $content
    do
        read http_status content_length<<<$(curl -Is $url | sed -n "1p;/Content-Length/p" | awk '{print $2}')
        if [[ $http_status == '200' || $http_status == '301' || $http_status == '302' || $content_length > 0 ]];then
            printf "[\e[1;32m%-10s\e[0m]\t\t\t%5s \n" "OK" $url
        else
            src_status=1
            printf "[\e[1;31m%-10s\e[0m]\t\t\t%5s \n" "Faild" $url
        fi

    done
    if [ $src_status -gt 0 ];then
        echo -e "\n\n\e[1;31mSorry~,the url is invalid, please change source download url...\e[0m"
        return 1
    fi
    return 0
}

sed -n "/http/p;/ftp/p" opsh.ini \
    | awk '{print $3}' | tr '\n' ' ' | get_header || exit
