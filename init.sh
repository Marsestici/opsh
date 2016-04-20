#!/bin/sh

DIRNAME=`pwd`

render() {
	
	for file in `ls $1`
	do
		#local currfile=$1"/"$file
		if [ -d $file ];then
			#echo $currfile
			render $1"/"$file
		else
			#if [ $currfile != $DIRNAME"/"${0##*/} ] && [ ${currfile##*.} == 'sh' ]
			#if [ ] 	
			#then
#				. $currfile	
			#	echo $currfile
			echo $file
			#fi
		fi
	done


}
render $DIRNAME

