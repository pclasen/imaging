#! /bin/csh -ef

#########################################
# organize NRSA data and run FAST	#
#					#
# Usage: ./prepNRSA.csh <file>		#
#########################################

## REQUIRES accurate "sublist.txt"
## DEPENDENCIES: cpNRSA.csh, segFAST.csh

set DIR = $STUDY_DIR
set file = $DIR/$1

foreach line ("`cat $file`")

    # assign sub from file 
    set sub = "$line"
    
    if (-d $DIR/$sub) then
    else
	# copy files from drive
	cpNRSA.csh $sub
    endif

    if (-f $DIR/$sub/ana/brainmask_seg.nii.gz) then
    else
	# run FAST segmentation
	segFAST.csh $sub
    endif
end

echo "prepNRSA DONE" 
