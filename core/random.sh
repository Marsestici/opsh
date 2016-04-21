#!/bin/sh

aaa.bbb.ccc.random(){
		
	random=`head -n 1 /dev/urandom | md5sum | head -c $1`
	echo $random
}


