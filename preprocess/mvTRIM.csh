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
    set fun = $sub

    if ($1 == MIG)

    	# phase 1
    	mv $fun/p1_run1_trim.nii.gz $fun/P1_R1_trim.nii.gz
    	mv $fun/p1_run2_trim.nii.gz $fun/P1_R2_trim.nii.gz

    	# phase 2
    	mv $fun/p2_run1_trim.nii.gz $fun/P2_R1_trim.nii.gz
    	mv $fun/p2_run2_trim.nii.gz $fun/P2_R2_trim.nii.gz
    	mv $fun/p2_run3_trim.nii.gz $fun/P2_R3_trim.nii.gz
    	mv $fun/p2_run4_trim.nii.gz $fun/P2_R4_trim.nii.gz
    	mv $fun/p2_run5_trim.nii.gz $fun/P2_R5_trim.nii.gz
    	mv $fun/p2_run6_trim.nii.gz $fun/P2_R6_trim.nii.gz
    	mv $fun/p2_run7_trim.nii.gz $fun/P2_R7_trim.nii.gz
    	mv $fun/p2_run8_trim.nii.gz $fun/P2_R8_trim.nii.gz

		# rest    
    	mv $fun/rest_run1_trim.nii.gz $fun/rest_trim.nii.gz

    else if ($1 == RAP)

    	mv $fun/prae_run1_trim.nii.gz $fun/R1_trim.nii.gz
    	mv $fun/prae_run2_trim.nii.gz $fun/R2_trim.nii.gz
    	mv $fun/prae_run3_trim.nii.gz $fun/R3_trim.nii.gz
    	mv $fun/prae_run4_trim.nii.gz $fun/R4_trim.nii.gz

    endif

end # for loop

# end