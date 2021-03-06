#!/bin/csh

#####################################
# copy subjects from SNI to local	#
# Usage:	./cpSNI.csh	<study> 	#
# Ex:		./cpSNI.csh	MIG			#
# p.clasen							#
#####################################

set server = /Volumes/iang/biac3/gotlib7/data/$1
set DIR = ~/Documents/$1
set file = $DIR/doc/asublist.txt

cd $server

find . -type d -name "$1*" | awk -F'/' '{print $2}' > $DIR/doc/asublist.txt

cd ~

foreach line ("`cat $file`")	    

    # assign sub from file 
    set sub = "$line"

    # copy files if not already done
	rsync -av $server/$sub $DIR/

	# remove redundancies 
	if ($1 == MIG) then
		if (-d $DIR/$sub/be/raw) then
			rm -f $DIR/$sub/be/repref*
		endif
	endif

echo "SNI to Local updated on:" `date` >>  $DIR/doc/copyLog.txt

end # for loop
