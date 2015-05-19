#!/bin/csh

#########################################
# copy subjects from SNI to Local 		#
# Usage:	./cpSNI.csh <study> 		#
# Ex:		./cpSNI.csh MIG				#
# p.clasen								#
#########################################

set server = /Volumes/iang/biac3/gotlib7/data/peter
set DIR = ~/Documents/$1
set file = $DIR/doc/asublist.txt

foreach line ("`cat $file`")	    

    # assign sub from file 
    set sub = "$line"

    # copy files if not already done
	rsync -av $DIR/$sub $server/$1/

end # for loop
# end