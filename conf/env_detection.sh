#! /bin/bash
# 200 301 302 Content-Length
clear
echo "Now detection remote source code valid..."
yum install mlocate -q -y >> /dev/null;updatedb

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


sed -nr "/http[s]?:/p;/ftp:/p" $opshPath/conf/opsh.ini \
    | awk '{print $3}' | tr '\n' ' ' | get_header || exit

echo -e "\n\nNow detection local environment..."
for bin in $(sed -nr "/^bin\s+/p" $opshPath/conf/opsh.ini | awk '{print $3}');do
    peg=0
    for f in `locate -r .*\/"$bin"$ | xargs file 2> /dev/null | awk '{print $2}'`;do 
        [[ $f == 'ELF' ]] && peg=1
    done
    [ $peg == 1 ] &&  printf "[\e[1;31m%-10s\e[0m]\t\t\t%-5s \n" "Installed" $bin || printf "[\e[1;32m%-10s\e[0m]\t\t\t%-5s \n" "Ready" $bin
done
echo -e "\n\n\e[1;31mDo you want to continue to do it...[y/n]\e[0m"
read key
[[ $key == 'n' ]] && exit

