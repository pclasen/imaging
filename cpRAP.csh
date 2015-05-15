#!/bin/csh

#########################################
# copy subjects from SNI to local	#
#					#
# Usage: ./cpRAP.csh             	#
#########################################

set server = /Volumes/iang/biac3/gotlib7/data/RAP
set DIR = $STUDY_DIR # set in environment (e.g., ~/Documents/RAP)
set file = $DIR/doc/SNI_files_copied.txt

echo "SNI to Local updated on" `date` >>  $DIR/doc/copy_log.txt

cd $server

find . -type d -name "RAP*" | awk -F'/' '{print $2}' > $DIR/doc/SNI_files_copied.txt

cd ~

foreach line ("`cat $file`")	    

    # assign sub from file 
    set sub = "$line"

    # copy files if not already done
    if (-d $DIR/$sub) then
    else
	cp -r $server/$sub $DIR/
    endif

end # for loop
