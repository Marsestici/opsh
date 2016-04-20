#!/bin/sh

DIRNAME=`pwd`

render() {
	
	for file in `ls $1`
	do
		local currfile=$1"/"$file
		if [ -d $currfile ];then
			render $currfile	
		else
			if [ $currfile != $DIRNAME"/"${0##*/} ] && [ ${currfile##*.} == 'sh' ]
			then
				echo $currfile	
			fi
		fi
	done


}
render $DIRNAME

