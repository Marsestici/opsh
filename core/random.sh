#!/bin/sh
namespace=Core
random(){
		
	random=`head -n 1 /dev/urandom | md5sum | head -c $1`
	echo $random
}


