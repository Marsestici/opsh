#! /bin/bash
# 200 301 302 Content-Length
get_header() {
    http_status=$(curl -I $1 | sed -n "1p" | awk '{print $2}')
    if [[ $http_status == '200' || $http_status == '301' ]];then
        echo 'ok';
    else
        echo "faild";
    fi
}

sed -n "/http/p;/ftp/p" opsh.ini \
    | awk '{print $3}' \
    | xargs -i curl -I {} | head -n 1

