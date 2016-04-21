#!/bin/sh

DIRNAME=`pwd`

render() {
	
	for file in `ls $1`
	do
		#local currfile=$1"/"$file
		if [ -d $1"/"$file ];then
			#echo $currfile
			render $1"/"$file
		else
			currfile=$1"/"$file
			#echo $currfile
			#if [ ${currfile##*.} == 'sh' ];then
			#echo $DIRNAME"/"${0##*/}	
			#echo "currfile:"$currfile
			#if [ $currfile != $DIRNAME"/"${0##*/} ] && [ ${currfile##*.} == 'sh' ]
			if [ $file != 'init.sh' ] && [ ${currfile##*.} == 'sh' ]	
			then
				:
			#if [ ] 	
			#then
			.  $1"/"$file	
			echo $currfile
			#. $currfile
	#		echo $file
			#fi
			fi
		fi
	done


}
render $DIRNAME

