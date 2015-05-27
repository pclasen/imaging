#!/bin/csh

#########################################
# rename trimmed files 					#
# Usage:	./mvTRIM.csh <study> 		#
# Ex:		./mvTRIM.csh MIG			#
# p.clasen								#
#########################################

set DIR = ~/Documents/$1
set file = $DIR/doc/asublist.txt 

foreach line ("`cat $file`")	    

    # assign sub from file 
    set sub = "$line"
    set fun = $DIR/$sub/fun

    if ($1 == MIG) then

    	# phase 1
    	mv $fun/p1_run1_trim.nii.gz $fun/P1R1_trim.nii.gz
    	mv $fun/p1_run2_trim.nii.gz $fun/P1R2_trim.nii.gz

    	# phase 2
    	mv $fun/p2_run1_trim.nii.gz $fun/P2R1_trim.nii.gz
    	mv $fun/p2_run2_trim.nii.gz $fun/P2R2_trim.nii.gz
    	mv $fun/p2_run3_trim.nii.gz $fun/P2R3_trim.nii.gz
    	mv $fun/p2_run4_trim.nii.gz $fun/P2R4_trim.nii.gz
    	mv $fun/p2_run5_trim.nii.gz $fun/P2R5_trim.nii.gz
    	mv $fun/p2_run6_trim.nii.gz $fun/P2R6_trim.nii.gz
    	mv $fun/p2_run7_trim.nii.gz $fun/P2R7_trim.nii.gz
    	mv $fun/p2_run8_trim.nii.gz $fun/P2R8_trim.nii.gz

		# rest    
    	mv $fun/rest_run1_trim.nii.gz $fun/rest_trim.nii.gz

    else if ($1 == RAP) then

    	mv $fun/prae_run1_trim.nii.gz $fun/R1_trim.nii.gz
    	mv $fun/prae_run2_trim.nii.gz $fun/R2_trim.nii.gz
    	mv $fun/prae_run3_trim.nii.gz $fun/R3_trim.nii.gz
    	mv $fun/prae_run4_trim.nii.gz $fun/R4_trim.nii.gz

    endif

end # for loop

# end