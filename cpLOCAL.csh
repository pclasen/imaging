#!/bin/csh

#########################################
# copy subjects from SNI to Local 		#
# Usage:	./cpSNI.csh <study> 		#
# Ex:		./cpSNI.csh MIG				#
# p.clasen								#
#########################################

set server = /Volumes/iang/biac3/gotlib7/data/$1
set DIR = ~/Documents/$1
set file = $DIR/doc/asublist.txt
set doc = $server/doc/syncLoc.txt

foreach line ("`cat $file`")	    

    # assign sub from file 
    set sub = "$line"

    # copy files if not already done
	rsync -av $DIR/$sub $server/$1/

end # for loop

echo "Local (peter) to SNI update on:" `date` >> $doc

# end